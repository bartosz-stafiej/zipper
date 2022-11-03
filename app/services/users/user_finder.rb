# frozen_string_literal: true

module Users
  class UserFinder
    def self.find_by_credentials(email:, password:)
      user = User.find_by(email: email)

      user if user&.authenticate(password)
    end
  end
end
