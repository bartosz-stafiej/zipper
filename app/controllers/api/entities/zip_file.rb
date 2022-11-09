# frozen_string_literal: true

module Api
  module Entities
    class ZipFile < Grape::Entity
      include Rails.application.routes.url_helpers

      root 'data'

      expose :id, documentation: { type: 'Integer' }
      expose :blob, documentation: { type: 'String', description: 'Blob details of file' }
      expose :url, documentation: { type: 'String', description: 'Url for downloading file' } do |file, _options|
        rails_blob_url(file, only_path: true)
      end
    end
  end
end
