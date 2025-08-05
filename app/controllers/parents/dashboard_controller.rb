# frozen_string_literal: true

class Parents::DashboardController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  def index
    @children = User.where(parent_id: current_user.id).includes(%i[avatar_attachment athlete_profile])
    @notifications = Notification.where(notifiable_id: current_user.id, notifiable_type: 'User', viewed: false)
    @displayed_notifications = Notification.where(notifiable_id: current_user.id, notifiable_type: 'User',
                                                  viewed: false).last(5)
  end
end
