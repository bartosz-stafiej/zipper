# frozen_string_literal: true

module Api
  module V1
    class Base < Grape::API
      include Api::ErrorsRescuer

      helpers Api::ErrorsHandler
      helpers Api::AuthHelper

      prefix 'api'
      version 'v1', using: :path

      mount Api::V1::Auth::Login
      mount Api::V1::Users::SignUp
      mount Api::V1::Users::Me
      mount Api::V1::Attachments::Create
      mount Api::V1::Attachments::Index
    end
  end
end
