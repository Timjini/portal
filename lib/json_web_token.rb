class JsonWebToken
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JsonWebToken.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def self.decode(token)
    decoded = JsonWebToken.decode(token, Rails.application.credentials.secret_key_base)[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JsonWebToken::ExpiredSignature, JsonWebToken::VerificationError => e
    nil
  end

   def self.valid_payload(payload)
    if expired(payload)
        puts"============Invalid token"
      return false
    else
      return true
      puts "============ valid token"
    end
  end

   # Validates if the token is expired by exp parameter
  def self.expired(payload)
    Time.at(payload['exp']) < Time.now
  end
end
