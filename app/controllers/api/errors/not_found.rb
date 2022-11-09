# frozen_string_literal: true

module Api
  module Errors
    class NotFound < BaseError
      STATUS = 404
      DEFAULT_MESSAGE = I18n.t('errors.api.not_found.default_message')

      def initialize(message = DEFAULT_MESSAGE, status = STATUS)
        super(message, status)
      end
    end
  end
end
