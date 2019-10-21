class JsonWebToken

  SECRETE_KEY = Rails.application.secrets.secret_key_base

  def self.encode(payload)
    payload[:generate_date] = DateTime.now
    JWT.encode(payload, SECRETE_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRETE_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  end

end