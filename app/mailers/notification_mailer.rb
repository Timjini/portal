# frozen_string_literal: true

# app/mailers/notification_mailer.rb
class NotificationMailer < ApplicationMailer
  def notification_email(user_email, category, message)
    @category = category
    @message = message

    mail(to: user_email, subject: 'Notification') # rubocop:disable Rails/I18nLocaleTexts
  end
end
