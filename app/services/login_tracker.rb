class LoginTracker
  def self.record_login(user)
    unless user.user_logins.today.exists?
      user.user_logins.create(login_at: Time.current)
    end
  end
end