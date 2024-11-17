# frozen_string_literal: true

module Api
  module V2
    class DcpaEventsController < Api::V1::BaseController # rubocop:disable Style/Documentation
      skip_before_action :authenticate_user!

      def index
        dcpa_events = DcpaEvent.find_by(event_type: params[:event_type], status: 'active')
        render json: { status: 'success', data: DcpaEventSerializer.new(dcpa_events).serializable_hash }, status: :ok
      end
    end
  end
end
