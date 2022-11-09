# frozen_string_literal: true

module Helpers
  module AuthHelper
    def auth_token(user)
      JsonWebToken.encode({ user_id: user.id })
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AuthHelper, type: :request
end
