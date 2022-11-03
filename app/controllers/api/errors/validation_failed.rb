# frozen_string_literal: true

module Api
  module Errors
    class ValidationFailed < BaseError
      STATUS = 422
      DEFAULT_MESSAGE = I18n.t('errors.api.validation_failed.default_message')

      def initialize(status = STATUS, message = DEFAULT_MESSAGE, details: {})
        super(message, status)
        @details = details
      end

      attr_reader :details
    end
  end
end
