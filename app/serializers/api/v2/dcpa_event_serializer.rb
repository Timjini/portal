# frozen_string_literal: true

module Api
  module V2
    class DcpaEventSerializer < ActiveModel::Serializer
      attributes :id, :title, :coach, :dates, :start_time_formated, :end_time_formated, :location, :ages_available, :price,
                 :dcpa_discount, :extras, :event_type, :status, :dcpa_price, :image_url

      def event_type
        object.event_type.humanize
      end

      def start_time_formated
        object.time_start.strftime('%H:%M') if object.time_start.present?
      end

      def end_time_formated
        object.time_end.strftime('%H:%M') if object.time_end.present?
      end

      def dcpa_price
        (object.price - (object.price * object.dcpa_discount / 100)).round(2)
      end

      def image_url
        return nil unless object.image.attached? && object.persisted?

        Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true)
      end
    end
  end
end
