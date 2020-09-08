Rails.application.routes.draw do
  root to: 'static#index'

  get '/signin', to: 'sessions#new', as: 'signin'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  get '/signup', to: 'users#new', as: 'signup'
  get '/home', to: 'users#show'

  resources :users, except: [:new, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
