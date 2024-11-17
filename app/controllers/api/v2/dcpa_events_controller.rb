# frozen_string_literal: true

module Api
  module V2
    class DcpaEventsController < Api::V1::BaseController # rubocop:disable Style/Documentation
      skip_before_action :authenticate_user!

      def index
        @dcpa_events = DcpaEvents.find_by(event_type: param[:even_type], status: 'active')
        render json: @dcpa_events, status: :ok
      end
    end
  end
end
