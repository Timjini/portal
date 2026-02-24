# frozen_string_literal: true

# Use a specific use_cassette
# VCR.use_cassette('billing_v1') do
#   service.create_billing
# end
#
# to record new episode
# vcr: { record: :new_episodes }

require 'rails_helper'
RSpec.describe BillingService, type: :request do
  let(:user) { create(:user) }
  describe 'creates a mandate', vcr: true do
    # it 'returns FAILED - 1 when the currency/scheme mismatch occurs' do
    #   service = BillingService.new(200, 'new payment', user)

    #   result = service.create_billing

    #   expect(result).to eq('FAILED - 1')
    # end

    # it 'returns billing request data' do
    #   service = BillingService.new(200, 'new payment', user)

    #   result = service.create_billing

    #   expect(result).to be_a(GoCardlessPro::Resources::BillingRequest)
    #   expect(result).to have_attributes(status: 'pending')

    #   expect(result.payment_request).to include(
    #     'amount' => 200,
    #     'currency' => 'GBP',
    #     'scheme' => 'faster_payments'
    #   )

    #   expect(result.mandate_request).to include(
    #     'scheme' => 'bacs',
    #     'verify' => 'recommended'
    #   )
    # end

    it 'return subscription id ' do
      service = BillingService.new(:user)

      res = service.get_subscription

      expect(res).to include(
        'id' => 'PL01KJ72NZX1WS1XDT1KQQ8742SE'
      )
    end
  end
end
