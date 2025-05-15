# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # include MailSender
  def test_email
    mail(to: 'hatim.jini@gmail.com', subject: 'Test Email', from: 'info@chambersforsport.com') do |format| # rubocop:disable Rails/I18nLocaleTexts
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
    @resource = user
    @token = token
    mail(to: @resource.email, subject: 'Password Reset Instructions') # rubocop:disable Rails/I18nLocaleTexts
  end
end
