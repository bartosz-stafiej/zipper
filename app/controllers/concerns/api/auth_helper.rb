# frozen_string_literal: true

module Api
  module AuthHelper
    def authorize_request!
      raise(Api::Errors::Unauthorized) unless current_user.present?
    end

    def current_user
      @current_user ||= Users::UserFinder.find_by_token(auth_token)
    end

    private

    def auth_token
      request.headers['Authorization']&.split('Bearer ')&.second
    end
  end
end
