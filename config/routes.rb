Rails.application.routes.draw do
  resources :users
  resources :events
  resources :attendances
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post 'signin', to: 'users#create'
  get 'users/show'
  root 'events#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
