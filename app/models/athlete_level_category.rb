# frozen_string_literal: true

class AthleteLevelCategory < ApplicationRecord
  belongs_to :athlete_level
  belongs_to :kpi_category

  validates :step_number, uniqueness: { scope: :athlete_level_category_id }

  def level_name
    athlete_level.name
  end

  def category_name
    kpi_category.name
  end

  def breadcrumb
    [athlete_level&.name, kpi_category&.name].compact.join(' > ')
  end
end
