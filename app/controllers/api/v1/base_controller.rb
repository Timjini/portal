class Api::V1::BaseController < ApiBaseController
    protect_from_forgery with: :null_session
    before_action :authenticate_request!
    protected
    # 
    def authenticate_request!
        my_payload = payload
        puts"===========#{payload}"
        if !payload || !JsonWebToken.valid_payload(payload)
        return invalid_authentication
        end
        
        load_current_user!
        invalid_authentication unless @current_user
    end

    def invalid_authentication
        render json: {error: 'Invalid Request'}, status: :unauthorized
    end

    private
    # Deconstructs the Authorization header and decodes the JWT token.
    def payload
        auth_header = request.headers['Authorization']
        token = auth_header.split(' ').last
        decoded_token = JsonWebToken.decode(token)
        return decoded_token
    rescue
        nil
    end
    

    # Sets the @current_user with the user_id from payload
    def load_current_user!
        # puts"Loading current user: #{payload}"
        if request.headers['Authorization'].present?
            token = request.headers['Authorization'].split(' ').last
            payload = JsonWebToken.decode(token)
            puts"#{payload}=============="
            if payload.present?
            id = payload['user_id']
            @current_user = User.find_by(id: id)
            puts "#{@current_user.inspect}"
            else
            return false
            end
        else
            return false
        end
    end

end