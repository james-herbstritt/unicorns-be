Rails.application.routes.draw do

    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    get '/logged_in', to: 'session#is_logged_in?' 

    post '/signup', to: 'users#create'

    resources :users, only: [:create, :show, :index]

end
