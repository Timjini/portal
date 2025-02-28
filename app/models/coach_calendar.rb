# frozen_string_literal: true

class CoachCalendar < ApplicationRecord
  belongs_to :user
  has_many :time_slots, dependent: :destroy
end
