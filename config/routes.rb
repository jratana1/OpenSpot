Rails.application.routes.draw do
  get '/authenticate-google', to: 'sessions#authenticate_google'
  
  get 'auth/:provider/callback', to: 'users#create'
  get 'auth/failure' => 'users#index'

  resources :tables
  resources :restaurants
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
