class TasterSessionBookingsController < ApplicationController
    before_action :authenticate_user!

    def index 
        @taster_session_bookings = TasterSessionBooking.all.paginate(page: params[:page], per_page: 10).order(:created_at)
    end

end