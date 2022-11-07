# frozen_string_literal: true

module Api
  module Entities
    module Attachments
      class Details < Grape::Entity
        include Rails.application.routes.url_helpers

        expose :id, documentation: { type: 'Integer' }
        expose :zip_file, documentation: { type: 'String', description: 'Url of zip file' } do |attachment, _options|
          rails_blob_url(attachment.zip_file, only_path: true)
        end
        expose :password,
               documentation: { type: 'String', description: 'Password to decrypt zip file' } do |_attachment, options|
          options[:password]
        end
        expose :created_at, documentation: { type: 'Datetime' }
      end
    end
  end
end
