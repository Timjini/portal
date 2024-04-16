class Api::V1::AuthController < Api::V1::BaseController
    # before_action :authenticate_user!

    # user.auth_token = JsonWebToken.encode({user_id: user.id })
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
					user.auth_token = JsonWebToken.encode({ user_id: user.id })
					userData = ActiveModelSerializers::SerializableResource.new(user, each_serializer: Api::V1::UsersSerializer);
					result = {type: 'Success', data: userData, message: ["User singin successfully."],status: 200}
					render json: result
				return
			end
			# if validPassword(params[:user][:password], user.password_salt, user.encrypt_password)
			# 	tokenExpire = Date.today + 365.days
			# 	user.auth_token = JsonWebToken.encode({ user_id: user.id, user_type: 'USER', exp: tokenExpire.to_time.to_i })
			# 	if user.save!
			# 		userData = ActiveModelSerializers::SerializableResource.new(user, each_serializer: Api::V1::UserSerializer);
			# 		userSkillMapList = UserSkillMap.where(user_id: user.id).order(id: 'asc');
			# 		result = {type: 'Success', userSkillMaps: userSkillMapList, data: userData, message: ["User singin successfully."],status: 200}
			# 		response.headers['Access-Control-Allow-Origin'] = '*'
			# 		render json: result
			# 		return
			# 	end
			# else
			# 	return api_error(status: 500, errors: ["Your password is incorrect."])
			# end
		end
	end
end
        