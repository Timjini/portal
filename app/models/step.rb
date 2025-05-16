# frozen_string_literal: true
class Step < ApplicationRecord
  belongs_to :athlete_level_category
  # belongs_to :kpi_category

  has_many :step_exercises # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :exercises, through: :step_exercises

  def full_breadcrumb
    "#{athlete_level_category.breadcrumb} > #{step_number}"
  end
end
