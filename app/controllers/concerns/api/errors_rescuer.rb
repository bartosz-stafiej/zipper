# frozen_string_literal: true

module Api
  module ErrorsRescuer
    extend ActiveSupport::Concern

    included do
      rescue_from Api::Errors::BaseError, with: :handle_api_error
    end
  end
end
