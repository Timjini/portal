# frozen_string_literal: true

class LoginTracker
  def self.record_login(user)
    return if user.blank?

    # Update core user fields
    user.update(
      last_login_at: Time.current,
      login_count: user.login_count.to_i + 1,
      active: true
    )

    # Record detailed login (if using user_logins table)
    return if user.user_logins.today.exists?

    user.user_logins.create(login_at: Time.current)
  end

  def self.record_error(user)
    return if user.blank?

    user.update(
      error_count: user.error_count.to_i + 1,
      updated_at: Time.current
    )
  end
end
