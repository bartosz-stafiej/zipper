# frozen_string_literal: true

module Helpers
  module JsonResponseHelper
    def json_response
      JSON.parse(response.body)
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::JsonResponseHelper, type: :request
end
