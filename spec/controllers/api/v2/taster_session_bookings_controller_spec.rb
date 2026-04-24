# frozen_string_literal: true

require 'rails_helper'

# RSpec.configure { |c| c.before { expect(controller).not_to be_nil } }

RSpec.describe Api::V2::TasterSessionBookingsController, type: :controller do
  describe 'taster session booking' do
    request_data = {
      firstName: 'John',
      lastName: 'Doe',
      athleteFullName: 'John Doe',
      email: 'johndoe@example.com',
      phone: '+44 1234 567890',
      address: '123 Example Street, London, UK',
      role: 'athlete',
      birth_date: '1990-05-15',
      healthIssues: 'None',
      price: 124.00,
      duration: 'month',
      approvalStatus: 'pending',
      paymentStatus: 'pending'
    }

    it 'creates a taster session booking requires a Training Package', vcr: true do
      # executing the test
      post :create, params: { taster_session_booking: request_data, format: :json }
      # Expectations
      expect(response.media_type).to eq 'application/json'
      expect(response.status).to eq 422
    end
  end
end
