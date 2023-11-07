class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new

    @role_labels = { "athlete" => "Athlete", "athlete_parent" => "Parent" }
  end

  def create
    @user = User.create(user_params)

    puts "#{params.inspect}"

    if @user.persisted? 
      puts "Athelete was successfully created"
      sign_in(@user)  # Manually sign in the user
      flash[:success] = "Athlete Profile created!"
      redirect_to dashboard_student_users_path
    else
      flash[:alert] = "Oops, something went wrong!"
      puts "Something went wrong"
      render 'new'
    end
  end

  
  prepend_view_path 'app/views/users'

  private
  def user_params
    params.require(:user).permit(:email, :encrypted_password, :dob, :phone , :username, :first_name, :last_name, :address, :city , :avatar , :password, :password_confirmation , :user_type)
  end
end