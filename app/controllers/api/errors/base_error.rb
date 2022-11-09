# frozen_string_literal: true

module Api
  module Errors
    class BaseError < StandardError
      def initialize(message, status)
        super(message)
        @status = status
      end

      attr_reader :status
    end
  end
end
