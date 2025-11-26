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
    # This will automatically render the welcome_email.html.erb and welcome_email.text.erb templates
    mail(to: @user.email, subject: 'Welcome to Chambers For Sport') # rubocop:disable Rails/I18nLocaleTexts
  end

  def reset_password_instructions(user, token, _opts = {})
    Rails.logger.info("Preparing to send reset password email to #{user.email}")
    @resource = user
    @token = token
    @reset_url = edit_user_password_url(reset_password_token: @token)
    Rails.logger.info("Reset URL: #{@reset_url}")

    begin
      BrevoMailerService.new(@resource, @reset_url).send_reset_password_email
    rescue StandardError => e
      Rails.logger.error("Failed to send reset password email: #{e.message}")
    end
  end
end
