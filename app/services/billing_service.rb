# frozen_string_literal: true

class BillingService
  def initialize(user)
    # @amount = amount
    # @description = description
    @user = user

    @currency = ENV.fetch('PORTAL_CURRENCY', nil)

    @client = GoCardlessPro::Client.new(
      access_token: ENV.fetch('GOCARDLESS_TOKEN', nil),
      environment: :sandbox
    )
    @scheme = 'bacs'
  end

  # def create_billing
  #   res = @client.billing_requests.create(params: loading_params)
  #   Rails.logger.info("created billing #{res}")
  #   billing_request_flow(res.id)
  # rescue GoCardlessPro::InvalidStateError
  #   'FAILED - 1'
  # end

  def loading_params
    {
      payment_request: {
        description: @description,
        amount: @amount,
        currency: @currency
      },
      mandate_request: {
        scheme: @scheme
      }
    }
  end

  def list_billing_requests
    @client.billing_requests.list
  end

  def billing_request_flow(billing_id)
    flow = @client.billing_request_flows.create(
      params: {
        redirect_uri: 'http://localhost:3000/payments/landing',
        exit_uri: 'http://localhost:3000/payments/exit',
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

    Rails.logger.info("billing flow #{flow}")

    flow.authorisation_url
  end

  def get_subscription
    @client.subscriptions.get('BRT01KJ72NZYRSK6DSY0GVHTR873Q')
  end
end
