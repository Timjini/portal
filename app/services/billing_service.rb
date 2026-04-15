# frozen_string_literal: true

class BillingService
  def initialize(user)
    @user = user
    @plan = user.plan
    @currency = ENV.fetch('PORTAL_CURRENCY', nil)

    @client = GoCardlessPro::Client.new(
      access_token: ENV.fetch('GOCARDLESS_TOKEN', nil),
      environment: :sandbox
    )
    @scheme = 'bacs'
  end

  # function handling multiple tasks !
  def create_billing
    res = @client.billing_requests.create(params: loading_params)
    begin
      return nil unless @user.user_plan

      save_billing_information_to_user(res)
    rescue StandardError => e
      Rails.logger.info("failed to save data to user #{e.message}")
    end
    billing_request_flow(res.id)
  rescue GoCardlessPro::InvalidStateError
    'FAILED - 1'
  end

  def billing_request_flow(billing_id) # rubocop:disable Metrics/MethodLength
    flow = @client.billing_request_flows.create(
      params: {
        redirect_uri: ENV.fetch('GOCARDLESS_LANDING_PAGE', nil),
        exit_uri: ENV.fetch('GOCARDLESS_EXIT_PAGE', nil),
        prefilled_customer: {
          given_name: @user.first_name,
          family_name: @user.last_name,
          email: @user.email
        },
        links: {
          billing_request: billing_id
        }
      }
    )
    flow.authorisation_url
  end

  def create_subscription # rubocop:disable Metrics/MethodLength
    response = @client.subscriptions.create(
      params: {
        amount: @user.plan.amount,
        currency: 'GBP',
        name: @user.plan.name,
        interval_unit: 'monthly',
        interval: 1,
        day_of_month: 1,
        start_date: '2026-04-20',
        links: {
          mandate: @user.payments.last.links['mandate_request']
        }
      }
    )

    Rails.logger.info("response #{response.inspect}")
  rescue StandardError => e
    Rails.logger.info("error catching #{e.message}")
  end

  def subscription
    @client.subscriptions.get('')
  end

  def list_billing_requests
    @client.billing_requests.get('')
  end

  def list_mandates
    @client.mandate_imports.create(params: { scheme: @scheme })
  end

  def loading_params
    {
      mandate_request: {
        scheme: @scheme
      }
    }
  end

  def save_billing_information_to_user(res)
    links_data = {
      'request_id' => res.id,
      'customer' => res.links.customer,
      'customer_billing_detail' => res.links.customer_billing_detail,
      'creditor' => res.links.creditor,
      'organisation' => res.links.organisation,
      'mandate_request' => res.links.mandate_request
    }
    Payment.create(user_id: @user.id, status: 'pending', user_plan_id: @user.user_plan.id, amount: @plan.amount,
                   links: links_data)
  end
end
