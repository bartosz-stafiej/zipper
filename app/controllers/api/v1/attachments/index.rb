# frozen_string_literal: true

module Api
  module V1
    module Attachments
      class Index < Grape::API
        helpers Grape::Pagy::Helpers
        format :json

        before { authorize_request! }

        namespace :attachments do
          desc 'List of current users\'s attachments'

          params do
            use :pagy
          end

          get do
            attachments = Attachment.where(owner_id: current_user.id)
            paginated_attachments = pagy(attachments)

            status 200
            present paginated_attachments, with: Api::Entities::Attachment
          end
        end
      end
    end
  end
end
