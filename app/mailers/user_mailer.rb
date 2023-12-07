class UserMailer < ApplicationMailer
  
  def test_email
    mail(to: 'hatim.jini@gmail.com', subject: 'Test Email') do |format|
      format.text { render plain: 'This is a test email sent from MailCatcher.' }
    end
  end
  
end
