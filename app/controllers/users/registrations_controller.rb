class Users::RegistrationsController < Devise::RegistrationsController
  include AthleteProfilesHelper

  def new
    @user = User.new

    # @role_labels = { "athlete" => "Athlete", "athlete_parent" => "Parent" }
  end

  def create
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
      age = (Date.today - dob).to_i / 365

      if age < 18 
        flash[:alert] = "Parental guidances needed to create an account."
        return 
      else 
        @user.save
      end
    end

    if @user.persisted?
      handle_successful_creation
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

  def handle_successful_creation
    if @user.role == "athlete"
      create_athlete_profile(@user.id , params[:user][:dob])
      puts "Athlete Profile created**************************"
    end

    sign_in(@user)  # Manually sign in the user
    	# begin 
			# UserMailer.welcome_email(user).deliver_now
			# rescue Exception => e
			# 	puts "Error sending welcome email"
			# end

    flash[:success] = "Athlete Profile created!"
    redirect_to root_path
  end
end