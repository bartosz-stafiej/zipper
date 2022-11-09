# frozen_string_literal: true

class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base

  class << self
    def encode(payload, exp: 12.hours.from_now)
      JWT.encode(payload.merge(exp: exp.to_i), SECRET_KEY)
    end

    def decode(encoded_token)
      decoded_token = decode_jwt_token(encoded_token)
      parse_to_hash_with_indifferent_access(decoded_token)
    end

    def decode_jwt_token(token)
      JWT.decode(token, SECRET_KEY).first
    end

    def parse_to_hash_with_indifferent_access(decoded_token)
      HashWithIndifferentAccess.new(decoded_token)
    end
  end
end
