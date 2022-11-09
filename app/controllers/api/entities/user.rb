# frozen_string_literal: true

module Api
  module Entities
    class User < Grape::Entity
      expose :id, documentation: { type: 'Integer' }
      expose :email, documentation: { type: 'String' }
    end
  end
end
