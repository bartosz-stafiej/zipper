# frozen_string_literal: true

module Api
  module ErrorsRescuer
    extend ActiveSupport::Concern

    included do
      rescue_from Api::Errors::BaseError, with: :handle_api_error
      rescue_from JWT::DecodeError, with: :handle_unauthorized
      rescue_from Zip::EntryExistsError, with: :handle_upload_conflict
      rescue_from Pagy::VariableError, with: :handle_pagy_variables
    end
  end
end
