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
    @steps = Step.includes(%i[exercises athlete_level_category])
    @assessments = Assessment.where(athlete_id: @athlete.id).order(created_at: :desc)
  end

  def new
    @athlete = User.find(params[:athlete_id])
    @assessment = @athlete.assessments.new
    @kpi_categories = KpiCategory.order(:id)
    @structured_data = ExerciseStructureQuery.new.call
  end

  def create
    puts "Params: #{params.inspect}"
    @athlete = User.find(assessment_params[:athlete_id])

    puts "Athlete: #{@athlete.inspect}"
    @assessment = Assessment.new(assessment_params)
    @assessment.coach = current_user
    @assessment.athlete = @athlete

    if @assessment.save
      redirect_to all_accounts_accounts_path, notice: 'Assessment saved successfully'
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
