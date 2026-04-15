# frozen_string_literal: true

module Api
  module V2
    class WebhooksController < Api::V1::BaseController
      include ActionController::Live

      protect_from_forgery except: :create

      def create # rubocop:disable Metrics/MethodLength
        webhook_endpoint_secret = ENV.fetch('GOCARDLESS_WEBHOOK_ENDPOINT_SECRET', nil)

        request_body = request.raw_post

        signature_header = request.headers['Webhook-Signature']

        begin
          events = GoCardlessPro::Webhook.parse(request_body: request_body,
                                                signature_header: signature_header,
                                                webhook_endpoint_secret: webhook_endpoint_secret)

          # Process the events...
          Rails.logger.info("process event =====> #{events.inspect}")
          render status: :no_content, nothing: true
        rescue GoCardlessPro::Webhook::InvalidSignatureError
          render status: 498, nothing: true
        end
      end
    end
  end
end
