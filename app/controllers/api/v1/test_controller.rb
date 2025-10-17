# frozen_string_literal: true

module Api
  module V1
    class TestController < Api::V1::BaseController
      def index
        Rails.logger.debug current_user.inspect
      end
    end
  end
end
