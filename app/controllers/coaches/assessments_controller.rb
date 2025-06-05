# frozen_string_literal: true

class Coaches::AssessmentsController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  def index
    @kpi_categories = KpiCategory.order(:id)
    @structured_data = ExerciseStructureQuery.new.call
  end

  def show
    @kpi_categories = KpiCategory.order(:id)
    @structured_data = ExerciseStructureQuery.new.call
    @athlete = User.find(params[:id])
  end

  def create
    @athlete = User.find(params[:athlete_id])
    @assessment = Assessment.new(assessment_params)
    @assessment.coach = current_user
    @assessment.athlete = @athlete

    if @assessment.save
      redirect_to athlete_path(@athlete), notice: 'Assessment saved successfully'
    else
      @kpi_categories = KpiCategory.all
      @structured_data = ExerciseStructureQuery.new.call
      render :new
    end
  end

  def require_coach
    return if current_user.role == 'coach'

    redirect_to root_path, alert: 'Only coaches can perform assessments'
  end

  def assessment_params
    params.require(:assessment).permit(
      :recommendation,
      :notes,
      kpi_data: {}
    )
  end
end
