# frozen_string_literal: true

class AthleteLevelCategory < ApplicationRecord
  belongs_to :athlete_level
  belongs_to :kpi_category

  def level_name
    athlete_level.name
  end

  def category_name
    kpi_category.name
  end

  def breadcrumb
    athlete_level.name.concat(' > ', kpi_category.name)
  end
end
