# frozen_string_literal: true

module Api
  module V1
    module Users
      class SignUp < Grape::API
        format :json
        desc 'Sign up'

        namespace 'users/sign_up' do
          params do
            requires :email, type: String
            requires :password, type: String
          end

          post do
            contract = ::Users::CreateContract.new
            contract_validator = Contracts::ContractValidator.new(contract: contract, params: params)
            validation_results = contract_validator.validate!

            user = User.create!(validation_results)

            status 200
            present user.attributes, with: Entities::Users::UserDetails
          end
        end
      end
    end
  end
end
