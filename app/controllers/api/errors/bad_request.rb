# frozen_string_literal: true

module Api
  module Errors
    class BadRequest < BaseError
      STATUS = 400
      DEFAULT_MESSAGE = I18n.t('errors.api.bad_request.default_message')

      def initialize(message = DEFAULT_MESSAGE, status = STATUS)
        super(message, status)
      end
    end
  end
end
