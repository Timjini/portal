# frozen_string_literal: true

class BillingService
  def initialize(amount, description, user)
    @amount = amount
    @description = description
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
    billing_id = res.id
  rescue GoCardlessPro::InvalidStateError
    'FAILED - 1'
  end

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
end
