# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # include MailSender
  def test_email
    mail(to: 'hatim.jini@gmail.com', subject: 'Test Email', from: 'no-reply@club.chambersforsport.com') do |format| # rubocop:disable Rails/I18nLocaleTexts
      format.text { render plain: 'This is a test email sent from MailCatcher.' }
    end
  end

  def welcome_email(user)
    @user = user
    @url  = 'https://club.chambersforsport.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Chambers For Sport') # rubocop:disable Rails/I18nLocaleTexts
  end

  def reset_password_instructions(user, token, _opts = {}) # rubocop:disable Metrics/MethodLength
    @reset_url = edit_user_password_url(reset_password_token: token)
    email_setting = {
      reset_url: @reset_url,
      template_id: 1,
      user: user,
      to: user.email,
      params: {
        reset_url: @reset_url,
        username: user.username || user.email
      }
    }

    begin
      BrevoMailerService.new(email_setting).send
    rescue StandardError => e
      Rails.logger.error("Failed to send reset password email: #{e.message}")
    end
  end
end
