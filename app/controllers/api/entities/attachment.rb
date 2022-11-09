# frozen_string_literal: true

module Api
  module Entities
    class Attachment < Grape::Entity
      root 'data'

      expose :id, documentation: { type: 'Integer' }
      expose :created_at, documentation: { type: 'Datetime' }
      expose :password,
             documentation: { type: 'String', description: 'Password to decrypt zip file' } do |_attachment, options|
        options[:password]
      end
      expose :zip_file,
             if: lambda { |attachment, _options| attachment.zip_file.attached? },
             documentation: { type: 'String', description: 'Zip file details' },
             with: Api::Entities::ZipFile
    end
  end
end
