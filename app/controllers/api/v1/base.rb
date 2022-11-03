# frozen_string_literal: true

module Api
  module V1
    class Base < Grape::API
      include Api::ErrorsRescuer
      helpers Api::ErrorsHandler

      prefix 'api'
      version 'v1', using: :path

      mount Api::V1::Auth::Login
      mount Api::V1::Users::SignUp
    end
  end
end
