# frozen_string_literal: true

class AthleteLevelCategory < ApplicationRecord
  belongs_to :athlete_level
  belongs_to :kpi_category

  validates :athlete_level_id,
            uniqueness: { scope: :kpi_category_id, message: 'and KPI category combination must be unique' } # rubocop:disable Rails/I18nLocaleTexts

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
