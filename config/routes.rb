Rails.application.routes.draw do
  # get 'index', to: 'users#index'
  # get 'signup', to: 'users#new'
  root 'users#index'
  resources :users

  resources :sessions
  get '/login', to: 'sessions#new'
end
