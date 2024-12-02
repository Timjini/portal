# frozen_string_literal: true

# app/services/athlete_checklist_status_service.rb
class AthleteChecklistStatusService
  def initialize(params)
    @params = params
    @athlete = AthleteProfile.find(@params[:id])
    @user = User.find_by(id: @athlete.user_id)
  end

  def call
    levels = fetch_levels
    levels_count = UserLevel.where(user_id: @user.id).count
    percentage = calculate_percentage(levels_count)

    status = determine_level_status(levels)
    Rails.logger.debug { "=========================> levels #{levels}  ,,,,, #{status}" }
    checklist_items_completed = completed_checklist_items

    {
      levels: levels,
      athlete: @athlete,
      user: @user,
      percentage: percentage,
      status: status,
      checklist_items_completed: checklist_items_completed
    }
  end

  private

  def fetch_levels
    if @params[:level].present?
      Level.where(degree: @params[:level])
    else
      Level.order(:degree, :step)
    end
  end

  def calculate_percentage(levels_count)
    total = 125.0
    (levels_count / total) * 100
  end

  def determine_level_status(levels)
    athlete_level = @athlete.athlete_level.where(status: 'completed')
    status = {}

    if athlete_level.blank? && levels.present?
      status[levels.first.id] = 'enabled'
      levels[1..].each { |level| status[level.id] = 'disabled' }
    else
      levels.each do |level|
        status[level.id] = athlete_level.exists?(level_id: level.id) ? 'enabled' : 'disabled'
      end
    end

    status
  end

  def completed_checklist_items
    UserChecklist.where(
      user_id: @athlete.user_id,
      user_level_id: UserLevel.where(user_id: @athlete.user_id, status: 'completed').select(:id),
      completed: true
    )
  end
end
