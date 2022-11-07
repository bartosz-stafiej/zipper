# frozen_string_literal: true

module Attachments
  class Creator
    def initialize(data:, user:, password:)
      @data = data
      @user = user
      @password = password
    end

    def call
      attachment = Attachment.create!(owner: @user)
      zip_file = create_zip_file

      attachment.zip_file.attach(
        {
          io: zip_file,
          filename: zip_filename(attachment),
          content_type: 'application/zip'
        }
      )

      attachment
    end

    private

    def create_zip_file
      zip_file_creator =
        Attachments::FilesZipper.new(files: @data[:files], password: @password)

      zip_file_creator.call
    end

    def zip_filename(attachment)
      "siepomaga_#{attachment.created_at.to_date}.zip"
    end
  end
end
