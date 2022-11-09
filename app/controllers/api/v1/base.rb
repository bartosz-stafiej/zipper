# frozen_string_literal: true

module Api
  module V1
    class Base < Grape::API
      include Api::ErrorsRescuer

      helpers Api::ErrorsHandler
      helpers Api::AuthHelper

      prefix 'api'
      version 'v1', using: :path

      mount Api::V1::Auth::Login, with: { entity: Api::Entities::Auth::JwtToken }
      mount Api::V1::Users::SignUp, with: { entity: Api::Entities::User }
      mount Api::V1::Users::Me, with: { entity: Api::Entities::User }
      mount Api::V1::Attachments::Create, with: { entity: Api::Entities::Attachment }
      mount Api::V1::Attachments::Index, with: { entity: Api::Entities::Attachment }

      add_swagger_documentation
    end
  end
end
