# frozen_string_literal: true

Rails.application.routes.draw do
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#logged_in?'

  post '/signup', to: 'users#create'

  resources :users, only: %i[create show index]
end
