# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    after_action :track_login, if: :user_signed_in?

    def show
      @user = User.find(params[:id])
    end

    def create # rubocop:disable Metrics/AbcSize
      user = User.find_by(username: params[:user][:email]&.downcase) || User.find_by(email: params[:user][:email]&.downcase) # rubocop:disable Layout/LineLength
      if user&.valid_password?(params[:user][:password])
        sign_in(user)
        redirect_to dashboard_path
      else
        redirect_to new_user_session_path, alert: t('devise.failure.invalid', authentication_keys: 'email/username')
      end
    end

    # TODO: move to the model or a service
    def track_login
      return unless current_user && response.successful?

      LoginTracker.record_login(current_user)
    end
  end
end
