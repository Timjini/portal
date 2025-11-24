# frozen_string_literal: true

class Coaches::AssessmentsController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  before_action :authenticate_user!
  load_and_authorize_resource except: [:create]
  # rescue_from Errors::QueryError, with: :handle_query_error
  def index
    @kpi_categories = KpiCategory.order(:id)
    @structured_data = ExerciseStructureQuery.new.call
    @users = User.all
  end

  def show
    @kpi_categories = KpiCategory.order(:id)
    begin
      @structured_data = ExerciseStructureQuery.new.call
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
    @athlete = User.find(params[:id])
    @steps = Step.all
    @assessments = Assessment.where(athlete_id: @athlete.id).order(created_at: :desc)
  end

  def new
    # @athlete = User.find(params[:athlete_id])
    # @assessment = @athlete.assessments.new
    # @kpi_categories = KpiCategory.order(:id)
    # @structured_data = ExerciseStructureQuery.new.call
  end

  def get_kpis # rubocop:disable Naming/AccessorMethodName
    service = KpiService.new(params)
    @levels = service.fetch_level_by_params

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('levels', partial: 'coaches/assessments/partials/users_search_form',
                                        locals: { levels: @levels })
        ]
      end
    end
  end

  def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity
    level_data = JSON.parse(params[:assessment][:kpi_data])
    user_ids = params[:user_ids].split(',')
    submitted_users = params[:assessment][:users] || {}

    user_ids.each do |u_id|
      user_checklists = submitted_users.dig(u_id, 'checklists') || {}

      completed = user_checklists.value?('1') || 0

      @assessment = Assessment.find_or_initialize_by(
        athlete_id: u_id,
        coach_id: current_user.id,
        level_id: level_data['id']
      )

      @assessment.update!(
        notes: 'Coach assessment',
        kpi_data: level_data,
        completed: completed,
        completed_at: Time.current
      )

      # Clear old checklist links
      @assessment.assessment_checklists.destroy_all

      # Create only the selected ones
      user_checklists.each do |checklist_id, value|
        next unless value == '1'

        AssessmentChecklist.create!(
          assessment_id: @assessment.id,
          check_list_id: checklist_id
        )
      end
    end

    redirect_to coaches_assessments_path, notice: 'Assessment saved successfully' # rubocop:disable Rails/I18nLocaleTexts
  rescue JSON::ParserError => e
    Rails.logger.error "Invalid JSON for level data: #{e.message}"
    redirect_to coaches_assessments_path, alert: 'Invalid level data provided.' # rubocop:disable Rails/I18nLocaleTexts
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Validation failed: #{e.message}"
    redirect_to coaches_assessments_path,
                alert: "Assessment could not be saved: #{e.record.errors.full_messages.to_sentence}"
  rescue StandardError => e
    Rails.logger.error "Unexpected error creating assessment: #{e.message}"
    redirect_to coaches_assessments_path, alert: 'An unexpected error occurred. Please try again.' # rubocop:disable Rails/I18nLocaleTexts
  end

  def get_assessments # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Naming/AccessorMethodName
    user_ids = params[:user_ids].to_s.split(',')
    level_id = params[:level_id]

    service = KpiService.new(Level.find(level_id))
    @levels = service.fetch_level_by_params

    @level = Level.find(level_id)
    @users = User.where(id: user_ids)

    # Fetch assessments for the users and level
    @assessments = Assessment.where(athlete_id: @users.pluck(:id), level_id: @level.id)

    respond_to do |format|
      format.html # renders get_assessments.html.erb
      format.json { render json: { users: @users, assessments: @assessments, levels: @levels } }
    end
  end

  def require_coach
    return if current_user.role == 'coach'

    redirect_to root_path, alert: 'Only coaches can perform assessments' # rubocop:disable Rails/I18nLocaleTexts
  end

  def assessment_params
    params.require(:assessment).permit(:kpi_data, :user_ids, :checklists)
  end
end
