# frozen_string_literal: true

module Api
  module V1
    class AuthController < Api::V1::BaseController
      require 'json_web_token'
      before_action :authenticate_user!, only: [:check_token]
      skip_before_action :verify_authenticity_token

      include AthleteProfilesHelper

      def login # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
        username = params[:user][:username]
        email = params[:user][:email]

        # here I need to validate if username and email are correct.
        user =  if username.present?
                  User.find_by(username: username.downcase.delete(' '))
                else
                  User.find_by(email: email.downcase.delete(' '))
                end

        if user.nil?
          render json: { type: 'Error', message: 'Account not found' }, status: :not_found
        elsif user&.valid_password?(params[:user][:password])
          JwtPolicy.call(user)
          user_data = ActiveModelSerializers::SerializableResource.new(user,
                                                                      each_serializer: Api::V1::UsersSerializer) # rubocop:disable Layout/ArgumentAlignment
          result = { type: 'Success', data: user_data, message: 'User signed in successfully.', status: 200 }
          render json: result
          nil
        else
          render json: { type: 'Error', message: 'Password or Email incorrect' }, status: :unauthorized
        end
      end

      def sign_up # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
        user = User.new(user_params)

        if params[:user][:dob].present?
          dob = Date.parse(params[:user][:dob])
          dob.strftime('%a, %d %b %Y')
          age = (Time.zone.today - dob).to_i / 365

          if age < 18
            result = api_error(status: 401, errors: ['Parental guidance needed to create an account.'])
            return result
          end
        else
          result = api_error(status: 400, errors: ['Date of birth is required.'])
          return result
        end

        # Generate JWT Token
        JwtPolicy.call(user)

        if user.save
          handle_successful_creation(user)
          user_data = ActiveModelSerializers::SerializableResource.new(user, each_serializer: Api::V1::UsersSerializer)
          result = { type: 'Success', data: user_data, message: ['Account created successfully.'], status: 200 }
          render json: result
          nil
        else
          api_error(status: 400, errors: user.errors.full_messages)

        end
      end

      def check_token
        Rails.logger.debug @current_user.inspect
        render json: @current_user
        nil
      end

      private

      def user_params
        params.require(:user).permit(:email, :username, :first_name, :last_name, :role, :password, :phone, :address)
      end

      # TODO: this should be an event
      def handle_successful_creation(user)
        create_athlete_profile(user.id, params[:user][:dob]) if user.role == 'athlete'
        begin
          UserMailer.welcome_email(user).deliver_now
        rescue Exception # rubocop:disable Lint/RescueException
          Rails.logger.debug 'Error sending welcome email'
        end
      end
    end
  end
end
