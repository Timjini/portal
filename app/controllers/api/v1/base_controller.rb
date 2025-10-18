# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApiBaseController
      require 'json_web_token'
      protect_from_forgery with: :null_session
      before_action :authenticate_user!

      protected

      def authenticate_user!
        payload
        return invalid_authentication if !payload || !JsonWebToken.valid_payload(payload)

        load_current_user!
        invalid_authentication unless @current_user
      end

      def invalid_authentication
        render json: { error: 'Invalid Request' }, status: :unauthorized
      end

      private

      def payload
        auth_header = request.headers['Authorization']
        token = auth_header.split.last
        JsonWebToken.decode(token)
      rescue StandardError
        nil
      end

      def load_current_user! # rubocop:disable Metrics/AbcSize
        Rails.logger.debug { "Loading current user: #{payload}" }
        return false if request.headers['Authorization'].blank?

        token = request.headers['Authorization'].split.last
        payload = JsonWebToken.decode(token)
        return false if payload.blank?

        id = payload['user_id']
        @current_user = User.find_by(id: id)
        Rails.logger.debug @current_user.inspect
      end
    end
  end
end
