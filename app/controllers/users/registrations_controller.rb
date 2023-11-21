class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new

    # @role_labels = { "athlete" => "Athlete", "athlete_parent" => "Parent" }
  end

  def create
    @user = User.create(user_params)

    if @user.persisted? 

      if @user.role == "athlete" 
        @athlete_profile = AthleteProfile.create(user_id: @user.id)
        puts "Athlete Profile created**************************"
      end

      sign_in(@user)  # Manually sign in the user

      flash[:success] = "Athlete Profile created!"
      redirect_to root_path
    else
      flash[:alert] = "Oops, something went wrong!"
      render 'new'
    end
  end

  
  # prepend_view_path 'app/views/users'

  private
  def user_params
    params.require(:user).permit(:email,:phone , :username, :first_name, :last_name, :address, :city , :avatar , :password, :password_confirmation , :role)
  end
end