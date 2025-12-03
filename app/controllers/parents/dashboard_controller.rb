# frozen_string_literal: true

class Parents::DashboardController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  def index
    @children = User.where(parent_id: current_user.id).includes(%i[avatar_attachment athlete_profile attendances])
    @notifications = Notification.where(notifiable_id: current_user.id, notifiable_type: 'User', viewed: false)
    @displayed_notifications = Notification.where(notifiable_id: current_user.id, notifiable_type: 'User',
                                                  viewed: false).last(5)
    # @milestones = Assessment
    #               .where(athlete_id: @children.pluck(:id))
    #               .includes(:assessment_checklists)
    #               .order(created_at: :desc)
    #               .limit(5)
    #
    #
    # @children_attendance = Attendance.where(user_id: @children.pluck(:id))
  end
end
