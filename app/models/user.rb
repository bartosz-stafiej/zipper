# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :attachments,
           inverse_of: :owner,
           dependent: :destroy
end
