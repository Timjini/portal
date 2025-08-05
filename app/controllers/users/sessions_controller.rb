# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    after_action :track_login, if: :user_signed_in?

    def show
      @user = User.find(params[:id])
    end
    # Custom code for User SessionsController

    # Specify custom view path
    #   prepend_view_path 'app/views/users'

    # define user sign in username and password
    def create # rubocop:disable Metrics/AbcSize
      user = User.find_by(username: params['user']['username']&.downcase) || User.find_by(email: params['user']['username']&.downcase) # rubocop:disable Layout/LineLength
      if user&.valid_password?(params[:user][:password])
        sign_in(user)
        redirect_to dashboard_path
      else
        error_message = 'Invalid username or password'
        redirect_to new_user_session_path, alert: error_message
      end
    end

    def track_login
      return unless current_user && response.successful?

      LoginTracker.record_login(current_user)
    end
  end
end
