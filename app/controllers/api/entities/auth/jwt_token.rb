# frozen_string_literal: true

module Api
  module Entities
    module Auth
      class JwtToken < Grape::Entity
        expose :token, documentation: { type: 'String', desc: 'JWT auth token' }
      end
    end
  end
end
