# frozen_string_literal: true

module Attachments
  class Creator
    def initialize(data:, user:, password:)
      @data = data
      @user = user
      @password = password
    end

    def call
      zip_file = create_zip_file

      Attachment.create!(
        owner: @user,
        zip_file: {
          io: zip_file,
          filename: "siepomaga_#{DateTime.now}.zip",
          content_type: 'application/zip'
        }
      )
    end

    private

    def create_zip_file
      zip_file_creator = Attachments::FilesZipper.new(files: @data[:files], password: @password)
      zip_file_creator.call
    end
  end
end
