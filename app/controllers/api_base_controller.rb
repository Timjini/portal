# frozen_string_literal: true

class ApiBaseController < ApplicationController
  require 'json_web_token'
  before_action :authenticate_user!

  def api_error(status: 500, errors: [])
    Rails.logger.debug errors.full_messages if !Rails.env.production? && errors.respond_to?(:full_messages)
    head status: status and return if errors.empty?

    render json: { data: {}, type: 'Error', status: status, message: errors }
  end
end
