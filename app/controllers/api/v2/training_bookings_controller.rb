class Api::V2::TrainingBookingsController < Api::V1::BaseController
    skip_before_action :authenticate_user!

    def index
      
    end

    def create
      begin
      @training_booking = TrainingBooking.new(training_booking_params)
      if @training_booking.save
        render json: {message: "Training booking created successfully", data: @training_booking}, status: :created
      end
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end


    private

    def training_booking_params
      params.require(:training_booking).permit(:user_id, :training_package_id, :first_name, :last_name, :athlete_full_name, :email, :phone, :address, :role, :birth_date, :health_issues, :training_package_name, :approval_status, :payment_status)
    end
end