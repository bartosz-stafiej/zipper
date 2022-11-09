# frozen_string_literal: true

class Attachment < ApplicationRecord
  has_one_attached :zip_file

  belongs_to :owner,
             inverse_of: :attachments,
             class_name: 'User'
end
