# frozen_string_literal: true

module Api
  module V2
    class TasterSessionBookingsController < Api::V1::BaseController
      skip_before_action :authenticate_user!

      def create
        # TasterSessionBooking (id: integer, user_id: integer, first_name: string, last_name: string,
        # athlete_full_name: string, email: string, phone: string, role: string,
        # birth_date: date, taster_session_date: date, health_issues: text)
        @training_booking = TasterSessionBooking.new(taster_session_booking_params)

        if @training_booking.save
          render json: { message: 'Training booking created successfully', data: @training_booking }, status: :created
        else
          render json: { errors: @training_booking.errors.full_messages }, status: :unprocessable_content
        end
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_content
      rescue StandardError => e
        render json: { error: "Something went wrong: #{e.message}" }, status: :internal_server_error
      end

      private

      def taster_session_booking_params
        params.except(:taster_session_booking).permit(
          :role, :first_name, :last_name, :email, :phone,
          :birth_date, :health_issues, :taster_session_date,
          :registration_confirmation,
          :policy_agreement,
          :athlete_full_name,
          :training_package_id
        )
      end
    end
  end
end
