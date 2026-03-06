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

  def create_billing
    res = @client.billing_requests.create(params: loading_params)
    # Save the billing id
    billing_request_flow(res.id)
  rescue GoCardlessPro::InvalidStateError
    'FAILED - 1'
  end

  def billing_request_flow(billing_id)
    flow = @client.billing_request_flows.create(
      params: {
        redirect_uri: 'http://localhost:3000/payments/landing',
        exit_uri: 'http://localhost:3000/payments/exit',
        prefilled_customer: {
          given_name: @user.first_name,
          family_name: @user.last_name,
          email: @user.email,
          phone_number: @user.phone,
          address_line1: '',
          postal_code: '',
          city: '',
          country_code: ''
        },
        links: {
          billing_request: billing_id
        }
      }
    )

    flow.authorisation_url
  end

  def create_subscription
    client.subscriptions.create(
      params: {
        amount: 1500,
        currency: @currency,
        interval_unit: 'monthly',
        day_of_month: '6',
        links: {
          # mandate: 'MD01KK0SNK56YDC1DPEVQX20E9A5'
          mandate: mandate_id
          # Mandate ID from the last section
        },
        metadata: {
          subscription_number: 'PL01KJ72NZX1WS1XDT1KQQ8742SE'
        }
      },
      headers: {
        'Idempotency-Key' => 'random_subscription_specific_string'
      }
    )
  end

  def subscription
    @client.subscriptions.get('BRT01KJ72NZYRSK6DSY0GVHTR873Q')
  end

  def list_billing_requests
    @client.billing_requests.list
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
end
