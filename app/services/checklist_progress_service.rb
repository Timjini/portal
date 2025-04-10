# frozen_string_literal: true

class ChecklistProgressService
  def initialize(params)
    @checklist_id = params[:checklist_item][:checklist_id]
    @user_id = params[:checklist_item][:user_id]
    @completed = params[:checklist_item][:completed]
    @user = User.find(@user_id)
    @athlete_profile = AthleteProfile.find_by(user_id: @user_id)
    @checklist = CheckList.find_by(id: @checklist_id)
  end

  def call
    return { status: 'error', message: 'Checklist not found!' } if @checklist.nil?

    ActiveRecord::Base.transaction do
      user_level = find_or_create_user_level
      find_or_create_user_checklist(user_level)
      update_level_status_and_athlete_profile(user_level)
      notify_user if all_checklist_items_completed?(user_level)
    end

    { status: 'success', message: 'Checklist updated!' }
  end

  private

  def find_or_create_user_level
    UserLevel.find_or_create_by(user_id: @user_id, level_id: @checklist.level_id) do |ul|
      ul.status = 'in_progress'
      ul.degree = @checklist.level.degree
    end
  end

  def find_or_create_user_checklist(user_level)
    UserChecklist.find_or_create_by(check_list_id: @checklist_id, user_id: @user_id) do |uc|
      uc.completed = @completed
      uc.user_level_id = user_level.id
      uc.title = @checklist.title
    end
  end

  def update_level_status_and_athlete_profile(_user_level) # rubocop:disable Metrics/AbcSize
    user_levels = UserLevel.where(user_id: @user_id, degree: @checklist.level.degree)
    completed_items = UserChecklist.where(user_id: @user_id, user_level_id: user_levels.pluck(:id),
                                          completed: true).count
    total_items = CheckList.joins(:level).where(levels: { degree: user_levels.pluck(:degree) }).count
    Rails.logger.debug do
      "user_levels:#{user_levels.inspect},completed_items:#{completed_items} , total_items:#{total_items}"
    end
    new_status = completed_items == total_items ? 'completed' : 'in_progress'
    # to be tested
    user_levels.update_all(status: new_status) # rubocop:disable Rails/SkipsModelValidations
    @athlete_profile.update(level: user_levels.first.level.degree)
  end

  def all_checklist_items_completed?(user_level)
    user_level.status == 'completed'
  end

  def notify_user
    message = "Congratulations! You have completed the level #{@athlete_profile.level}!"
    category = 'level'
    general_notification(@user, category, message)
  end
end
