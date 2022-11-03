# frozen_string_literal: true

module Api
  module ErrorsHandler
    def handle_api_error(error)
      error_body = create_error_body(error)

      error!(error_body, error.status)
    end

    private

    def create_error_body(error)
      case error
      when Api::Errors::ValidationFailed
        { error: error.message, details: error.details }
      else
        { error: error.message }
      end
    end
  end
end
