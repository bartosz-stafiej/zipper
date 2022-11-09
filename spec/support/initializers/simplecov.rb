# frozen_string_literal: true

require 'simplecov'

SimpleCov.start 'rails' do
  add_filter %r{^/app/controllers/concerns/}
  add_filter %r{^/app/controllers/api/errors/}
  add_filter %r{^/app/controllers/api/entities/}
  add_filter %r{^/app/controllers/application_controller.rb}
end
