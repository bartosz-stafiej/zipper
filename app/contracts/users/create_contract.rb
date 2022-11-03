# frozen_string_literal: true

module Users
  class CreateContract < ApplicationContract
    EMAIL_FORMAT = Constants::Users::Formats::EMAIL
    PASSWORD_FORMAT = Constants::Users::Formats::PASSWORD

    config.messages.namespace = 'users.create'

    json do
      required(:email).filled(:string, format?: EMAIL_FORMAT)
      required(:password).filled(:string, format?: PASSWORD_FORMAT)
    end

    rule(:email) do
      key.failure(:taken) if User.exists?(email: value)
    end
  end
end