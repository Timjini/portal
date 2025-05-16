# frozen_string_literal: true

class Exercise < ApplicationRecord
  has_one_attached :image
  has_many :step_exercises, dependent: :destroy
  before_save :normalize_array_fields

  def normalize_array_fields
    self.movement_patterns = movement_patterns.split(',').map(&:strip) if movement_patterns.is_a?(String)
    self.equipment = equipment.split(',').map(&:strip) if equipment.is_a?(String)
  end

  # has_many :steps, through: :step_exercises
  def image_url
    image.attached? ? image : 'user.png'
  end
end
