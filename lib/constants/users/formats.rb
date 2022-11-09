# frozen_string_literal: true

module Constants
  module Users
    module Formats
      EMAIL = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/.freeze
      PASSWORD = /\A
        (?=.{8,})          # Must contain 8 or more characters
        (?=.*\d)           # Must contain a digit
        (?=.*[a-z])        # Must contain a lower case character
        (?=.*[A-Z])        # Must contain an upper case character
        (?=.*[[:^alnum:]]) # Must contain a symbol
      /x.freeze
    end
  end
end
