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
RSpec.describe BillingService, type: :request, vcr: true do
  let(:user) { create(:user) }
  let(:plan) { create(:plan) }
  describe 'creates a mandate' do
    it 'create billing successfully' do
      user.plan = plan
      service = BillingService.new(user)
      VCR.use_cassette('gocardless/create_billing_successfully') do
        result = service.create_billing
        expect(result).to start_with('https://pay-sandbox.gocardless.com/billing')
      end
    end

    it 'create user subscription', vcr: { record: :new_episodes } do
      service = BillingService.new(user)
      service.create_subscription
    end
  end
end
