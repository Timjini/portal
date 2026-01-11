# frozen_string_literal: true

class JwtPolicy
  attr_reader :user
  EXPIRY_DATE = 10
  class << self
    def call(params)
      generate_token(params)
    end

    def generate_token(params)
      token_expire = Time.zone.today + EXPIRY_DATE.seconds
      params.auth_token = JsonWebToken.encode({ user_id: params.id, exp: token_expire.to_time.to_i })
    end

    def refresh_token
    end
  end
end
