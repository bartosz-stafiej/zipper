# frozen_string_literal: true

module Api
  module V1
    module Attachments
      class Create < Grape::API
        format :json
        desc 'Zip uploaded files'

        PASSWORD_LENGTH = 16

        before { authorize_request! }

        namespace :attachments do
          params do
            requires :files, type: Array[File]
          end

          post do
            contract = ::Attachments::CreateContract.new
            contract_validator = Contracts::ContractValidator.new(contract: contract, params: params)
            validation_results = contract_validator.validate!

            random_password = SecureRandom.hex(PASSWORD_LENGTH)
            creator = ::Attachments::Creator.new(data: validation_results,
                                                 user: current_user,
                                                 password: random_password)
            created_attachment = creator.call

            status 201
            present created_attachment, password: random_password, with: Entities::Attachment
          end
        end
      end
    end
  end
end
