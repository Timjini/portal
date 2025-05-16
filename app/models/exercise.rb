# frozen_string_literal: true

class Exercise < ApplicationRecord
  has_one_attached :image
  has_many :step_exercises, dependent: :destroy
  # has_many :steps, through: :step_exercises
  def image_url
    image.attached? ? image : 'user.png'
  end
end
