# frozen_string_literal: true

Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  mount Api::V1::Base => '/'

  resources :attachments, only: %i[index new]
end
