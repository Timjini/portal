# frozen_string_literal: true

class AthleteLevel < ApplicationRecord
  has_many :athlete_level_categories, dependent: :destroy
  has_many :kpi_categories, through: :athlete_level_categories

  LEVELS = {
    development: 0,
    intermediate: 1,
    advanced: 2
  }.freeze
end
