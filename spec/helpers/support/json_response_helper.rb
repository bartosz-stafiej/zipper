# frozen_string_literal: true

module Support
  module JsonResponseHelper
    def json_response
      JSON.parse(response.body)
    end
  end
end

RSpec.configure do |config|
  config.include Support::JsonResponseHelper, type: :request
end
