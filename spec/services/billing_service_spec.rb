# frozen_string_literal: true

# Use a specific use_cassette
# VCR.use_cassette('billing_v1') do
#   service.create_billing
# end
#
# to record new episode
# vcr: { record: :new_episodes }
require 'spec_helper'
require 'rails_helper'
RSpec.describe BillingService, type: :request, vcr: true do # rubocop:disable Metrics/BlockLength
  let(:user) { create(:user) }
  let(:plan) { create(:plan) }
  describe 'creates a mandate' do
    it 'create billing successfully' do
      user.plan = plan
      service = BillingService.new(user)
      result = service.create_billing

      expect(result).to start_with('https://pay-sandbox.gocardless.com/billing')
    end

    it 'returns billing request data' do
      service = BillingService.new(user)
      VCR.use_cassette('gocardless/returns_billing_requests_data') do
        result = service.list_billing_requests
      end
    end
  end
end
