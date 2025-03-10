# frozen_string_literal: true

class NotificationsController < ApplicationController
  def set_viewed
    @notification = Notification.find(params[:id])
    @notification.update(viewed: true)
    render json: { success: true }
  end
end
