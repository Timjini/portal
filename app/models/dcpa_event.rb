# frozen_string_literal: true

class DcpaEvent < ApplicationRecord
  before_save :strip_default_date
  has_one_attached :image
  EVENT_TYPES = %w[holiday_camp running_event].freeze
  STATUS = %w[draft active inactive].freeze

  validates :title, :coach, :location, :time_start, :time_end, :price, presence: true
  validates :dates, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :dcpa_discount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :event_type, inclusion: { in: EVENT_TYPES }
  validates :status, inclusion: { in: STATUS }
  validate :valid_dates_array
  validate :end_time_after_start_time

  def image_thumbnail
    if image.attached?
      # avatar.variant(resize: "150x150!").processed
      image
    else
      'image_holder.png'
    end
  end

  def strip_default_date
    self.time_start = time_start.strftime('%H:%M') if time_start.present?
    self.time_end = time_end.strftime('%H:%M') if time_end.present?
  end

  def status_color(status)
    case status
    when 'draft' then 'bg-gray-100 text-gray-800'
    when 'active' then 'bg-green-100 text-green-800'
    when 'inactive' then 'bg-red-100 text-red-800'
    else 'bg-blue-100 text-blue-800'
    end
  end

  private

  def valid_dates_array
    return unless dates.blank? || !dates.is_a?(Array) || dates.any? { |date| !date.is_a?(Date) }

    errors.add(:dates, 'must be an array of valid dates')
  end

  def end_time_after_start_time
    return unless time_start.present? && time_end.present? && time_start >= time_end

    errors.add(:time_end, 'must be after the start time')
  end
end
