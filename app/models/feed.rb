# frozen_string_literal: true

class Feed < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id', inverse_of: :feeds
  has_one_attached :media

  validates :feed_type, inclusion: { in: %w[video youtube event image] }

  def url
    metadata&.fetch('url', nil)
  end

  def event_date
    metadata&.fetch('event_date', nil)
  end
end
