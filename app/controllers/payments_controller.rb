# frozen_string_literal: true

require 'gocardless_pro'

class PaymentsController < ApplicationController
  def index
    @client = GoCardlessPro::Client.new(
      access_token: ENV.fetch('GOCARDLESS_TOKEN', nil),
      environment: :sandbox
    )

    @client.billing_requests.create(
      params: {
        payment_request: {
          description: 'First Payment',
          amount: '125',
          currency: 'GBP'
        },
        mandate_request: {
          scheme: 'pad',
          consent_type: 'recurring',
          currency: 'GBP'
        }

      }
    )
    Rails.logger(@client.inspect)
  end
end
