# frozen_string_literal: true

class Api::V2::DcpaEventSerializer < ActiveModel::Serializer # rubocop:disable Style/Documentation
  attributes :id, :title, :coach, :dates, :start_time_formated, :end_time_formated, :location, :ages_available, :price,
             :dcpa_discount, :extras, :event_type, :status, :dcpa_price, :image_thumbnail

  # Use humanized event type
  def event_type
    object.event_type.humanize
  end

  # Format the start time as HH:MM
  def start_time_formated
    object.time_start.strftime('%H:%M') if object.time_start.present?
  end

  # Format the end time as HH:MM
  def end_time_formated
    object.time_end.strftime('%H:%M') if object.time_end.present?
  end

  def dcpa_price
    (object.price - (object.price * object.dcpa_discount / 100)).round(2)
  end

  def image_thumbnail
    if object.image.attached?
      Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true)
    else
      'image_holder.png'
    end
  end
end
