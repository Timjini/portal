# frozen_string_literal: true

require 'dotenv/load'

class JsonWebToken
  def self.encode(payload, exp = 7.days.from_now)
    payload['exp'] = exp.to_i
    JWT.encode(payload, ENV.fetch('JWT_SECRET_KEY', nil), 'HS256')
  end

  # def self.encode(token)
  #   encode = JWT::Encode(token)
  # end

  def self.decode(token)
    decoded = JWT.decode(token, ENV.fetch('JWT_SECRET_KEY', nil), true, { algorithm: 'HS256' })[0]
    ActiveSupport::HashWithIndifferentAccess.new(decoded)
  rescue JWT::ExpiredSignature, JWT::VerificationError
    nil
  end

  def self.valid_payload(payload) # rubocop:disable Naming/PredicateMethod
    return true unless expired(payload)

    false
  end

  # Validates if the token is expired by exp parameter
  def self.expired(payload) # rubocop:disable Naming/PredicateMethod
    Time.zone.at(payload['exp']) < Time.zone.now
  end
end
