# frozen_string_literal: true

Rails.application.routes.draw do
  mount Api::V1::Base => '/'

  resources :attachments, only: %i[index new]
end
