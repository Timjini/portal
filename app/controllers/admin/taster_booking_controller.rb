# frozen_string_literal: true

module Admin
  class TasterBookingController < ApplicationController
    before_action :authenticate_user!
    authorize_resource class: false

    # Define actions for the TasterBooking controller
    # Assuming this controller manages taster bookings in the admin section
    # Adjust the actions as necessary based on your application's requirements
    before_action :set_taster_booking, only: %i[show edit update destroy]

    def index
      @taster_bookings = TasterBooking.where(dateSelect: Time.zone.today..).paginate(page: params[:page],
                                                                                     per_page: 10)
    end

    def show; end

    def new
      @taster_booking = TasterBooking.new
    end

    def edit; end

    def create
      @taster_booking = TasterBooking.new(taster_booking_params)

      if @taster_booking.save
        redirect_to @taster_booking, notice: 'Taster booking was successfully created.' # rubocop:disable Rails/I18nLocaleTexts
      else
        render :new
      end
    end

    def update
      if @taster_booking.update(taster_booking_params)
        flash[:notice] = 'Taster booking was successfully updated.' # rubocop:disable Rails/I18nLocaleTexts
        redirect_to edit_admin_taster_booking_path(@taster_booking)
      else
        render :edit
      end
    end

    def destroy
      @taster_booking.destroy
      redirect_to taster_bookings_url, notice: 'Taster booking was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
    end

    private

    def set_taster_booking
      @taster_booking = TasterBooking.find(params[:id])
    end

    def taster_booking_params # rubocop:disable Metrics/MethodLength
      params.require(:taster_booking).permit(
        :firstName,
        :lastName,
        :email,
        :phone,
        :athleteBirthDate,
        :parentFirstName,
        :parentLastName,
        :parentEmail,
        :parentPhone,
        :childFullName,
        :childBirthDate,
        :dateSelect,
        :healthIssues,
        :registrationConfirmation,
        :policyAgreement,
        :status
      )
    end
  end
end
