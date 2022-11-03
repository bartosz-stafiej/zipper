# frozen_string_literal: true

module Api
  module Entities
    module Users
      class UserDetails < Grape::Entity
        expose :id, documentation: { type: 'Integer' }
        expose :email, documentation: { type: 'String' }
      end
    end
  end
end
