# frozen_string_literal: true

module Api
  module V1
    class AuthController < Api::V1::BaseController
      require 'json_web_token'
      before_action :authenticate_user!, only: [:check_token]
      skip_before_action :verify_authenticity_token

      include AthleteProfilesHelper

      def login # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
        user = User.where('lower(email) = ?', params[:user][:email].downcase).first
        if user.nil?
          api_error(status: 404, errors: ["Sorry we didn't find you on CFS."])
        elsif user&.valid_password?(params[:user][:password])
          tokenExpire = Time.zone.today + 365.days # rubocop:disable Naming/VariableName
          user.auth_token = JsonWebToken.encode({ user_id: user.id, exp: tokenExpire.to_time.to_i }) # rubocop:disable Naming/VariableName
          userData = ActiveModelSerializers::SerializableResource.new(user, # rubocop:disable Naming/VariableName
                                                                      each_serializer: Api::V1::UsersSerializer)
          result = { type: 'Success', data: userData, message: ['User signin successfully.'], status: 200 } # rubocop:disable Naming/VariableName
          render json: result
          nil
        else
          api_error(status: 500, errors: ['Your password is incorrect.'])
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

        tokenExpire = Time.zone.today + 365.days # rubocop:disable Naming/VariableName
        user.auth_token = JsonWebToken.encode({ user_id: user.id, exp: tokenExpire.to_time.to_i }) # rubocop:disable Naming/VariableName

        if user.save
          handle_successful_creation(user)
          userData = ActiveModelSerializers::SerializableResource.new(user, each_serializer: Api::V1::UsersSerializer) # rubocop:disable Naming/VariableName
          result = { type: 'Success', data: userData, message: ['Account created successfully.'], status: 200 } # rubocop:disable Naming/VariableName
          render json: result
          nil
        else
          api_error(status: 400, errors: user.errors.full_messages)

        end
      end

      def check_token
        render json: @current_user
        nil
      end

      private

      def user_params
        params.require(:user).permit(:email, :username, :first_name, :last_name, :role, :password, :phone, :address)
      end

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
