# frozen_string_literal: true

module Api
  module V1
    module Users
      class Me < Grape::API
        format :json
        desc 'Details of current user'

        before { authorize_request! }

        namespace 'users/me' do
          get do
            status 200
            present current_user, with: Entities::User
          end
        end
      end
    end
  end
end
