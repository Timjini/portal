# frozen_string_literal: true

class JwtPolicy

  attr_reader :user

  EXPIRY_DATE = 10

  def initialize(user)
    @user = user
  end

  def generate_token
    token_expire = Time.zone.today + EXPIRY_DATE.seconds
    @user.auth_token = JsonWebToken.encode({ user_id: @user.id, exp: token_expire.to_time.to_i })
  end
end
