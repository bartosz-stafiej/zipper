# frozen_string_literal: true

module Api
  module Errors
    class Unauthorized < BaseError
      STATUS = 401
      DEFAULT_MESSAGE = I18n.t('errors.api.unauthorized.default_message')

      def initialize(message = DEFAULT_MESSAGE, status = STATUS)
        super(message, status)
      end
    end
  end
end
