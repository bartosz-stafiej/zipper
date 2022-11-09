# frozen_string_literal: true

root to: 'views/attachments#index'
get 'sign_in', to: 'views/users#login'
get 'sign_up', to: 'views/users#new'

resources :attachments, only: %i[new index], module: :views
