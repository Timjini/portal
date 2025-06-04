# frozen_string_literal: true

class StepExercise < ApplicationRecord
  belongs_to :step
  belongs_to :exercise

  def breadcrumb
    step.athlete_level.name + step.kpi_category
  end
end
