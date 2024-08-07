class Api::V1::TasterSessionBookingsController < ApplicationController
    skip_forgery_protection only: [:create]
    before_action :authenticate_user! ,except: [:create , :new]

    include UserHelper

    def create

        check_email = params[:email] || params[:parentEmail]
        user = User.find_by(email: check_email) 

        if user 
            render json: { error: "User already exists" }, status: 409
            return
        end

        duplicate_booking = TasterSessionBooking.find_by(email: check_email )

        if duplicate_booking
            render json: { error: "Booking already exists" }, status: 409
            return
        end

        session = TasterSessionBooking.new

        if params[:registration_confirmation] && params[:registration_confirmation] == "on"
            create_user(check_email ,params[:firstName],params[:lastName],params[:phone],params[:role],params[:childBirthDate],params[:athleteBirthDate],params[:parentEmail],params[:parentFirstName],params[:parentLastName],params[:parentPhone],params[:childFullName])
            # create_user(,params[:role],params[:childBirthDate],params[:athleteBirthDate])
        end

        if params[:role] && params[:role] == 'athlete'
            session.athlete_full_name = "#{params[:firstName]} #{params[:lastName]}"
            session.first_name = params[:firstName]
            session.last_name = params[:lastName]
            session.email = check_email
            session.phone = params[:phone]
            session.role = params[:role]
            session.birth_date = params[:athleteBirthDate]
            session.taster_session_date = params[:dateSelect]
            session.health_issues = params[:healthIssues]
            session.save
        elsif params[:role] && params[:role] == 'parent_user'
            session.athlete_full_name = params[:childFullName]
            session.first_name = params[:parentFirstName]
            session.last_name = params[:parentLastName]
            session.email = params[:parentEmail]
            session.phone = params[:parentPhone]
            session.role = params[:role]
            session.birth_date = params[:childBirthDate]
            session.taster_session_date = params[:dateSelect]
            session.health_issues = params[:healthIssues]
            session.save
        else
            render json: { status: :unprocessable_entity }

        end

        render json: {status: "success" , message: "Taster session booked successfully"}

    end

    def new
        @taster_session_booking = TasterSessionBooking.new
    end
end