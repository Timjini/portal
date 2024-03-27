class UserMailer < ApplicationMailer
  
  def test_email
    mail(to: 'hatim.jini@gmail.com', subject: 'Test Email', from:'info@chambersforsport.com') do |format|
      format.text { render plain: 'This is a test email sent from MailCatcher.' }
    end
  end

  def welcome_email(user)
    @user = user
    @url  = 'https://club.chambersforsport.net/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Chambers For Sport', from:'
    <EMAIL>') do |format|
      format.text { render plain: "Hello #{@user.first_name} #{@user.last_name}!" }
    end
  end
  
end
