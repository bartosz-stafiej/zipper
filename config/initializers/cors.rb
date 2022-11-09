# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch('REACT_APP_BACKEND_URL')
    resource '*', headers: :any, methods: :any
  end
end
