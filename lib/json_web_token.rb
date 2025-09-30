# frozen_string_literal: true

class JsonWebToken
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, ENV['JWT_SECRET_KEY'])
  end

  # def self.encode(token)
  #   encode = JWT::Encode(token)
  # end

  def self.decode(token)
    decoded = JWT.decode(token, ENV['JWT_SECRET_KEY'])[0]
    ActiveSupport::HashWithIndifferentAccess.new(decoded)
  rescue JWT::ExpiredSignature, JWT::VerificationError
    nil
  end

  def self.valid_payload(payload)
    return true unless expired(payload)

    false
  end

  # Validates if the token is expired by exp parameter
  def self.expired(payload)
    Time.zone.at(payload['exp']) < Time.zone.now
  end
end
