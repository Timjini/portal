module NotificationHelper

    def general_notification(user, category, message)
        parent = User.find_by(parent_id:user.parent_id, role:"parent") if user.role.in?(['parent_user', 'child_user'])

        notification_params = {
            body: message,
            viewed: false,
            category: category
        }

        Notification.create(notifiable: user, **notification_params)

        if parent
            Notification.create(notifiable: parent, **notification_params)
        end

        # find and destroy the oldest notification if the user has more than 5 notifications
        notifications = Notification.where(notifiable: user)
        if notifications.count > 5
            # keep only last notification and destroy all 
            notifications.last.destroy
        end
    end

end