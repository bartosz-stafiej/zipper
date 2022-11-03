# frozen_string_literal: true

module Api
  module V1
    module Auth
      class Login < Grape::API
        format :json
        desc 'Sign in'

        namespace :login do
          params do
            requires :email, type: String
            requires :password, type: String
          end

          post do
            user = ::Users::UserFinder.find_by_credentials(email: params[:email], password: params[:password])
            raise Api::Errors::Unauthorized unless user.present?

            token_generator = ::Auth::TokenGenerator.new(user: user)
            token = token_generator.call

            status 200
            present token, with: Entities::Auth::JwtToken
          end
        end
      end
    end
  end
end
