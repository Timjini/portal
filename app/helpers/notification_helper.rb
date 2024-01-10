module NotificationHelper

    def general_notification(user, category, message)
        parent = user.parent if user.role.in?(['parent_user', 'child_user'])

        notification_params = {
            body: message,
            viewed: false,
            category: category
        }

        Notification.create(notifiable: user, **notification_params)

        if parent
            Notification.create(notifiable: parent, **notification_params)
        end
    end

end