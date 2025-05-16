# frozen_string_literal: true

class KpiCategory < ApplicationRecord
  has_many :athlete_level_categories, dependent: :destroy
  has_many :athlete_levels, through: :athlete_level_categories
end
