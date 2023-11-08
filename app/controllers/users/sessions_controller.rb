class Users::SessionsController < Devise::SessionsController
  # Custom code for User SessionsController

  # Specify custom view path
#   prepend_view_path 'app/views/users'

    # define user sign in useranme and password
    def create
        user = User.find_by(username: params[:user][:username]) || User.find_by(email: params[:user][:username])
        if user && user.valid_password?(params[:user][:password])
          sign_in(user)
          redirect_to dashboard_path
        else
          flash[:alert] = "Invalid username or password"
          redirect_to new_user_session_path
        end
    end

    def show
        @user = User.find(params[:id])
    end
end