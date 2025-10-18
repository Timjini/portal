# frozen_string_literal: true

class Competition < ApplicationRecord
  has_one_attached :image
  has_many :competition_entries, dependent: :destroy

  enum :status, {
    active: 'active',
    draft: 'draft',
    cancelled: 'cancelled'
  }, prefix: true

  def competition_thumbnail
    if image.attached?
      image
    else
      'https://pub-bc4cae30cb704275a2d82ae56b32c9b6.r2.dev/cfs/dcpa1.webp'
    end
  end

  def participants
    competition_entries.count
  end
end
