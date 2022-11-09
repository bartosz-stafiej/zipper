# frozen_string_literal: true

# This file contains all the record creation needed to seed the database with its default values.
# The data can be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

user = User.create!(email: 'super_user@email.com', password: 'Password123!')

3.times do |i|
  file = File.open('spec/support/files/zip_helper.zip')

  Attachment.create!(
    owner: user,
    zip_file: {
      io: StringIO.new(file.read),
      filename: "siepomaga_file_#{i}.zip",
      content_type: 'application/zip'
    }
  )

  file.close
end
