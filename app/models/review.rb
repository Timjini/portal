# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :coach, class_name: 'User'
  belongs_to :reviewable, polymorphic: true

  validates :comment, presence: true
end
