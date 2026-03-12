# frozen_string_literal: true

require 'rails_helper'

RSpec.configure { |c| c.before { expect(controller).not_to be_nil } }

RSpec.describe Api::V2::TrainingBookingsController, type: :controller do # rubocop:disable Metrics/BlockLength
  describe 'training booking' do # rubocop:disable Metrics/BlockLength
    request_data = {
      firstName: 'John',
      lastName: 'Doe',
      athleteFullName: 'John Doe',
      email: 'johndoe@example.com',
      phone: '+44 1234 567890',
      address: '123 Example Street, London, UK',
      role: 'athlete',
      birthDate: '1990-05-15',
      healthIssues: 'None',
      price: 124.00,
      duration: 'month',
      approvalStatus: 'pending',
      paymentStatus: 'pending'
    }

    it 'creates a training booking' do
      # Preparing for test
      package = create(:training_package)
      request_data['training_package_id'] = package.id

      expect(package).to have_attributes(
        name: '1 session a week'
      )

      # executing the test
      post :create, params: { training_booking: request_data, format: :json }

      # Expectations
      expect(response.media_type).to eq 'application/json'
      expect(response.status).to eq 201
      expect(response.parsed_body['data']).to include('birth_date' => '1990-05-15')
    end
  end
end
