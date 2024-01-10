module NotificationHelper

    def general_notification(user, category, message)
  parent = User.find_by(parent_id: user.parent_id, role: "parent") if user.role.in?(['parent_user', 'child_user'])

  notification_params = {
    body: message,
    viewed: false,
    category: category
  }

  # Create the notification
  Notification.create(notifiable: user, **notification_params)

  # Send email to the user
  NotificationMailer.notification_email(user.email, category, message).deliver_now

  if parent
    # Create the notification for the parent
    Notification.create(notifiable: parent, **notification_params)

    # Send email to the parent
    NotificationMailer.notification_email(parent.email, category, message).deliver_now
  end

  # Find and destroy the oldest notification if the user has more than 5 notifications
  notifications = Notification.where(notifiable: user)
  if notifications.count > 5
    # Keep only the last notification and destroy all others
    notifications.last.destroy
  end
end


end