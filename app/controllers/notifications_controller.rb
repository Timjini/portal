class NotificationsController < ApplicationController

    def set_viewed
        @notification = Notification.find(params[:id])
        @notification.update(viewed: true)
        return json: { success: true }
    end
end