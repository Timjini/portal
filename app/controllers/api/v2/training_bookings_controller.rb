# frozen_string_literal: true

module Api
  module V2
    class TrainingBookingsController < Api::V1::BaseController
      skip_before_action :authenticate_user!

      def create
        @training_booking = TrainingBooking.new(training_booking_params)

        if @training_booking.save
          render json: { message: 'Training booking created successfully', data: @training_booking }, status: :created
        else
          render json: { errors: @training_booking.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
      rescue StandardError => e
        render json: { error: "Something went wrong: #{e.message}" }, status: :internal_server_error
      end

      private

      def training_booking_params
        params.require(:training_booking).permit(
          :user_id, :training_package_id, :first_name, :last_name, :athlete_full_name,
          :email, :phone, :address, :role, :birth_date, :health_issues,
          :training_package_name, :approval_status, :payment_status
        )
      end
    end
  end
end
