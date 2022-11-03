# frozen_string_literal: true

module Auth
  class TokenGenerator
    SECRET_KEY = Rails.application.credentials.jwt_secret

    def initialize(user:, exp: 12.hours.from_now)
      @user = user
      @exp = exp
    end

    def call
      token = generate_token

      { token: token }
    end

    private

    def generate_token
      JWT.encode(payload, SECRET_KEY)
    end

    def payload
      { user_id: @user.id, exp: @exp.to_i }
    end
  end
end
