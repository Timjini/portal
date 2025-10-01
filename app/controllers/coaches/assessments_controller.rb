# frozen_string_literal: true

class Coaches::AssessmentsController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  # rescue_from Errors::QueryError, with: :handle_query_error
  def index
    @kpi_categories = KpiCategory.order(:id)
    @structured_data = ExerciseStructureQuery.new.call
    @user = User.all
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

    puts "---------> #{params.inspect}"
    # @athlete = User.find(params[:athlete_id])
    # @assessment = @athlete.assessments.new
    # @kpi_categories = KpiCategory.order(:id)
    # @structured_data = ExerciseStructureQuery.new.call
  end

  def get_kpis
    service = KpiService.new(params)
    @levels = service.fetch_level_by_params

    # this is a terrible way of doing this !!
    @users = User.where(role: %i[athlete child_user])
    if !@levels.nil?
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("levels", partial: "coaches/assessments/level", locals: { levels: @levels, users: @users }),
          ]
        end
      end
    end
  end

  def create

    level_data = JSON.parse(params['level']['data'])
    check_lists = CheckList.where(level_id: level_data['id'])
    user_ids = params['user_ids'].split(',')
    begin
      user_ids.each do |u_id|
        
        @assessment = Assessment.find_or_initialize_by(
          athlete_id: u_id,
          coach_id: current_user.id,
          level_id: level_data['id']
        )
        
        @assessment.assign_attributes(
          notes: "",
          kpi_data: level_data,
          completed: true,
          completed_at: Time.now
        )
        @assessment.save!

        check_lists.each do |l|
          AssessmentChecklist.find_or_create_by!(
            assessment_id: @assessment.id,
            check_list_id: l.id
          )
        end
      end


        rescue StandardError => e
          Rails.logger.error "Error creating assessment: #{e.message}"
        end
    
        redirect_to coaches_assessments_path, notice: 'Assessment saved successfully'

  end

  # def create
  #   Rails.logger.info "------------------>, #{@levels.inspect}"
  #   Rails.logger.info "Assessment creation started with params: #{params.permit!.to_h}"

  #   @athlete = User.find(params[:athlete_id])
  #   Rails.logger.info "Athlete found===>: #{@athlete.inspect}"

  #   @raw_assesemnts = JSON.parse(params[:kpi_data].to_json) if params[:kpi_data].present?
  #   Rails.logger.info "Assessment raw data: #{params[:kpi_data].inspect}"

  #   begin
  #     @assessment = Assessment.new(
  #       notes: params[:notes],
  #       kpi_data: @raw_assesemnts,
  #       recommendation: params[:recommendation],
  #       athlete_id: @athlete.id,
  #       coach_id: current_user.id
  #     )
  #     @assessment.save!
  #     Rails.logger.info "Assessment object created: #{@assessment.inspect}"
  #   rescue StandardError => e
  #     Rails.logger.error "Error creating assessment: #{e.message}"
  #   end

  #   #   if @assessment.save
  #   #     Rails.logger.info "Assessment created successfully: #{@assessment.attributes}"
  #   #     redirect_to all_accounts_accounts_path, notice: 'Assessment saved successfully'
  #   #   else
  #   #     Rails.logger.error "Assessment failed to save: #{@assessment.errors.full_messages}"
  #   #     @kpi_categories = KpiCategory.all
  #   #     @structured_data = ExerciseStructureQuery.new.call
  #   #     render :new, status: :unprocessable_entity
  #   #   end
  #   # rescue ActiveRecord::RecordInvalid => e
  #   #   Rails.logger.error "Record invalid: #{e.message}\n#{e.record.errors.full_messages}"
  #   #   @kpi_categories = KpiCategory.all
  #   #   @structured_data = ExerciseStructureQuery.new.call
  #   #   render :new, status: :unprocessable_entity
  #   # rescue StandardError => e
  #   #   Rails.logger.error "Unexpected error: #{e.class} - #{e.message}\n#{e.backtrace.join("\n")}"
  #   #   redirect_to all_accounts_accounts_path, alert: 'Failed to create assessment'
  # end

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
