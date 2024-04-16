class Api::V1::AuthController < Api::V1::BaseController
    # before_action :authenticate_user!
	before_action :authenticate_request! , only: [:check_token]
	skip_before_action :verify_authenticity_token 

	include AthleteProfilesHelper

    def login
		user = User.where('lower(email) = ?', params[:user][:email].downcase).first
		if(user.nil?)
			return api_error(status: 404, errors: ["Sorry we didn't find you on CFS."])
			result = "new"
			render json: result
			return
		else
			if user && user.valid_password?(params[:user][:password])
				result = "Login"
					tokenExpire = Date.today + 365.days
					user.auth_token = JsonWebToken.encode({ user_id: user.id, exp: tokenExpire.to_time.to_i })
					userData = ActiveModelSerializers::SerializableResource.new(user, each_serializer: Api::V1::UsersSerializer);
					result = {type: 'Success', data: userData, message: ["User singin successfully."],status: 200}
					render json: result
				return
				else
				return api_error(status: 500, errors: ["Your password is incorrect."])
			end
		end
	end

	def sign_up
		user = User.new
		user.email = params[:user][:email]
		user.username = params[:user][:username].downcase
		user.first_name = params[:user][:first_name]
		user.last_name = params[:user][:last_name]
		user.role = params[:user][:role]
		user.password = params[:user][:password]
		user.phone = params[:user][:phone]
		user.address = params[:user][:address]
		# user.avatar = params[:user][:avatar]

		# if params[:user][:dob].present?
		# 	dob = Date.parse(params[:user][:dob])
		# 	formatted_dob = dob.strftime("%a, %d %b %Y")
		# 	age = (Date.today - formatted_dob).to_i / 365

		# 	if age < 18 
		# 	result = api_error(status: 401, errors: ['Parental guidance needed to create an account.'])
		# 	render json: result
		# 	return
		# 	end
		# else
		# 	result = api_error(status: 400, errors: ['Date of birth is required.'])
		# 	render json: result
		# 	return
  		# end

		tokenExpire = Date.today + 365.days
		user.auth_token = JsonWebToken.encode({ user_id: user.id ,  exp: tokenExpire.to_time.to_i  })

		if user.save
			handle_successful_creation(user)
			userData = ActiveModelSerializers::SerializableResource.new(user, each_serializer: Api::V1::UsersSerializer)
			result = { type: 'Success', data: userData, message: ['Account created successfully.'], status: 200 }
			render json: result
			return
		else
			result = api_error(status: 400, errors: user.errors.full_messages)
			return  result
		end
	end

	def check_token
		puts "=====================#{@current_user}"
		render json: @current_user
		return 
	end



	private

	def user_params
		params.require(:user).permit(:email, :username, :first_name, :last_name, :role, :password, :phone, :address, :avatar ,:dob)
	end

	def handle_successful_creation(user)
		if user.role == "athlete"
			create_athlete_profile(user.id , params[:user][:dob])
			puts "Athlete Profile created**************************"
		end

		UserMailer.welcome_email(user).deliver_now
  	end
end
        