# frozen_string_literal: true

Rails.application.routes.draw do
  mount Api::V1::Base => '/'
  mount GrapeSwaggerRails::Engine => '/swagger' unless Rails.env.production?

  draw(:views)
end
