# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # Parent Account
    @children = User.where(parent_id: current_user.id)
    @notifications = Notification.where(notifiable_id: current_user.id, notifiable_type: 'User', viewed: false)
    @displayed_notifications = Notification.where(notifiable_id: current_user.id, notifiable_type: 'User',
                                                  viewed: false).last(5)

    # Child Account

    # Athlete Account

    # Coach Account
  end

  def goals_rewards_acheivements; end
end
