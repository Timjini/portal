class Users::RegistrationsController < Devise::RegistrationsController
  include AthleteProfileHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
        sign_in(@user)
        flash[:success] = "Athlete Profile created!"
        redirect_to root_path
    else
        flash[:alert] = @user.errors.full_messages.join(", ")
        render 'new'
    end
  end


  
#   prepend_view_path 'app/views/users'

  private
  def user_params
    params.require(:user).permit(:email, :encrypted_password,:phone , :username, :first_name, :last_name, :address , :avatar , :password, :password_confirmation ,:role)
  end
end