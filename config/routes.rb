Rails.application.routes.draw do
  resources :purchases
  resources :budgets
  resources :cards
  resources :users, except: [:new, :show]

  get '/signin', to: 'sessions#new', as: 'signin'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  get '/signup', to: 'users#new', as: 'signup'
  get '/home', to: 'users#show'

  root to: 'static#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
