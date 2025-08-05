# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    include AthleteProfilesHelper

    def new
      @user = User.new

      # @role_labels = { "athlete" => "Athlete", "athlete_parent" => "Parent" }
    end

    def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      @user = User.new
      @user.email = params[:user][:email]
      @user.username = params[:user][:username].downcase
      @user.first_name = params[:user][:first_name]
      @user.last_name = params[:user][:last_name]
      @user.role = params[:user][:role]
      @user.password = params[:user][:password]
      @user.phone = params[:user][:phone]
      @user.address = params[:user][:address]
      @user.avatar = params[:user][:avatar]

      if params[:user][:dob]
        dob = Date.parse(params[:user][:dob])
        age = (Time.zone.today - dob).to_i / 365

        if age < 18
          flash[:alert] = 'Parental guidances needed to create an account.' # rubocop:disable Rails/I18nLocaleTexts
          return
        else
          @user.save
        end
      end

      if @user.persisted?
        handle_successful_creation
      else
        Rails.logger.debug { " User params: #{@user.errors.messages.inspect}" }
        flash[:alert] = "Oops, something went wrong: #{@user.errors.full_messages.to_sentence}"
        redirect_to new_user_registration_path
      end
    end

    # prepend_view_path 'app/views/users'

    private

    def user_params
      params.require(:user).permit(:email, :phone, :username, :first_name, :last_name, :address, :city, :avatar,
                                   :password, :password_confirmation, :role)
    end

    def handle_successful_creation
      create_athlete_profile(@user.id, params[:user][:dob]) if @user.role == 'athlete'

      sign_in(@user) # Manually sign in the user
      begin
        UserMailer.welcome_email(@user).deliver_now
      rescue Exception => e # rubocop:disable Lint/RescueException
        Rails.logger.debug { "Error sending email: #{e.message}" }
        ErrorLogger.log(e, context: { user_id: @user.id, action: 'send_welcome_email' })
      end

      flash[:success] = 'Athlete Profile created!' # rubocop:disable Rails/I18nLocaleTexts
      redirect_to root_path
    end
  end
end
