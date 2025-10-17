# frozen_string_literal: true

class AthleteChecklistStatusService
  def initialize(params)
    @params = params
    @athlete = AthleteProfile.includes(:user).find(@params[:id])
    @user = @athlete.user
  end

  def call
    levels = fetch_levels
    levels_count = count_completed_levels
    percentage = calculate_percentage(levels_count)

    status = determine_level_status(levels)
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
    permitted_params = %w[title degree category step]
    hash = @params.to_unsafe_h
    cleaned_params = hash.slice(*permitted_params).compact

    # Add index if you frequently filter by these columns
    Level.where(cleaned_params).order(:degree, :step, :category)
  end

  def count_completed_levels
    # Much faster than UserLevel.where.count
    UserLevel.where(user_id: @user.id, status: 'completed').count
  end

  def calculate_percentage(levels_count)
    total = 125.0
    (levels_count / total) * 100
  end

  def determine_level_status(levels)
    # Preload all completed athlete levels in one query
    completed_level_ids = @athlete.athlete_levels
                                  .where(status: 'completed')
                                  .pluck(:level_id)
                                  .to_set

    status = {}

    if completed_level_ids.empty? && levels.present?
      status[levels.first.id] = 'enabled'
      levels[1..].each { |level| status[level.id] = 'disabled' }
    else
      levels.each do |level|
        status[level.id] = completed_level_ids.include?(level.id) ? 'enabled' : 'disabled'
      end
    end

    status
  end

  def completed_checklist_items
    # Optimized query with proper indexing
    completed_level_ids = UserLevel.where(
      user_id: @athlete.user_id,
      status: 'completed'
    ).select(:id)

    UserChecklist.where(
      user_id: @athlete.user_id,
      user_level_id: completed_level_ids,
      completed: true
    )
  end
end
