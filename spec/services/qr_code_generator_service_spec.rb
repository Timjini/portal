# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

RSpec.describe QrCodeGeneratorService, type: :request do # rubocop:disable Metrics/BlockLength
  describe 'QR Code Generation Process' do # rubocop:disable Metrics/BlockLength
    let(:valid_training_package) do
      TrainingPackage.create!(
        name: 'Trial Package',
        description: '1 training session per week, billed monthly.',
        features: '["Access to group training"]',
        price: 38.0,
        duration_in_days: 30,
        package_type: 'group_training',
        training_type: 'group_training',
        duration: 'month',
        status: 'active',
        extra: {}
      )
    end

    let(:valid_booking) do
      TasterSessionBooking.create!(
        training_package_id: valid_training_package.id,
        first_name: 'Test',
        last_name: 'User',
        email: 'test@example.com',
        status: 'pending',
        extra: {}
      )
    end

    it 'generates a qr code for a taster_session_booking' do
      result = QrCodeGeneratorService.call(valid_booking, 'https://club.chambersforsport.com')

      expect(result).not_to be_nil
      expect(valid_booking.qr_code).to be_attached
    end
  end
end
