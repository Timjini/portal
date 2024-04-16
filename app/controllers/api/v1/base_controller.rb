class Api::V1::BaseController < ApiBaseController
    protect_from_forgery with: :null_session

    def api_error(status: 500, errors: [])
        unless Rails.env.production?
        puts errors.full_messages if errors.respond_to? :full_messages
        end
        head status: status and return if errors.empty?

        render json: {data: {},type: 'Error',status: status,message: errors}
    end

end