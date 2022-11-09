# frozen_string_literal: true

module Auth
  class TokenGenerator
    def initialize(user:, exp: 12.hours.from_now)
      @user = user
      @exp = exp
    end

    def call
      { token: generated_token }
    end

    private

    def generated_token
      JsonWebToken.encode(payload, exp: @exp)
    end

    def payload
      { user_id: @user.id }
    end
  end
end
