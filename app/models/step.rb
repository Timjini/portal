# frozen_string_literal: true

class Step < ApplicationRecord
  belongs_to :athlete_level_category
  # belongs_to :kpi_category

  has_many :step_exercises # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :exercises, through: :step_exercises

  validates :step_number, uniqueness: { scope: :athlete_level_category_id }

  def full_breadcrumb
    "#{athlete_level_category.athlete_level.name} > #{athlete_level_category.kpi_category.name} > Step #{step_number}"
  end
end
