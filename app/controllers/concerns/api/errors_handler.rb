# frozen_string_literal: true

module Api
  module ErrorsHandler
    def handle_unauthorized(_error)
      unauthorized = Api::Errors::Unauthorized.new

      handle_api_error(unauthorized)
    end

    def handle_api_error(error)
      error_body = create_error_body(error)

      error!(error_body, error.status)
    end

    def handle_upload_conflict(_error)
      error_message = I18n.t('errors.api.bad_request.uploads.conflict')
      unauthorized = Api::Errors::BadRequest.new(error_message)

      handle_api_error(unauthorized)
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
