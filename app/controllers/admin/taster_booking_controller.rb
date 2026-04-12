# frozen_string_literal: true

module Admin
  class TasterBookingController < ApplicationController
    before_action :authenticate_user!
    authorize_resource class: false

    before_action :set_taster_booking, only: %i[show edit update destroy]

    def index
      @taster_bookings = TasterSessionBooking.where(taster_session_date: Time.zone.today..)
                                             .paginate(page: params[:page], per_page: 10)
    end

    def show; end

    def new
      @taster_booking = TasterSessionBooking.new
    end

    def edit; end

    def create
      @taster_booking = TasterSessionBooking.new(taster_booking_params)

      if @taster_booking.save
        redirect_to @taster_booking, notice: 'Taster booking was successfully created.' # rubocop:disable Rails/I18nLocaleTexts
      else
        render :new
      end
    end

    def update
      Rails.logger.info("Updating......... #{taster_booking_params.inspect}")
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
      @taster_booking = TasterSessionBooking.find(params[:id])
    end

    def taster_booking_params # rubocop:disable Metrics/MethodLength
      params.require(:taster_session_booking).permit(
        :first_name,
        :last_name,
        :email,
        :phone,
        :athlete_birth_date,
        :parent_first_name,
        :parent_last_name,
        :parent_email,
        :parent_phone,
        :child_full_name,
        :child_birth_date,
        :date_select,
        :health_issues,
        :registration_confirmation,
        :policy_agreement,
        :status
      )
    end
  end
end
