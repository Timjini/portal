# frozen_string_literal: true

class Level < ApplicationRecord
  has_many :check_lists, dependent: :destroy
  has_many :user_levels, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :assessments


  enum :degree, { development: 0, intermediate: 1, advanced: 2 }
  enum :category, { information_management: 0, physical_strength: 1, motor_skills: 2, technical_ability: 3,
                    performance_time: 4 }
  enum :step, { one: 1, two: 2, three: 3, four: 4, five: 5 }
end
