# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def show
      @user = User.find(params[:id])
    end
    # Custom code for User SessionsController

    # Specify custom view path
    #   prepend_view_path 'app/views/users'

    # define user sign in username and password
    def create # rubocop:disable Metrics/AbcSize
      user = User.find_by(username: params[:user][:username].downcase) || User.find_by(email: params[:user][:username].downcase) # rubocop:disable Layout/LineLength
      if user&.valid_password?(params[:user][:password])
        sign_in(user)
        redirect_to dashboard_path
      else
        flash[:alert] = 'Invalid username or password' # rubocop:disable Rails/I18nLocaleTexts
        redirect_to new_user_session_path
      end
    end
  end
end
