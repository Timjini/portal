# frozen_string_literal: true

module NotificationHelper
  def general_notification(user, category, message) # rubocop:disable Metrics/MethodLength
    parent = User.find_by(parent_id: user.parent_id, role: 'parent') if user.role.in?(%w[parent_user child_user])

    notification_params = {
      body: message,
      viewed: false,
      category: category
    }

    Notification.create(notifiable: user, **notification_params)

    NotificationMailer.notification_email(user.email, category, message).deliver_now

    if parent
      Notification.create(notifiable: parent, **notification_params)

      NotificationMailer.notification_email(parent.email, category, message).deliver_now
    end

    notifications = Notification.where(notifiable: user)
    return unless notifications.count > 5

    notifications.last.destroy
  end
end
