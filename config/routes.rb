Rails.application.routes.draw do
  resources :budgets
  resources :cards do
    resources :benefits, shallow: true, except: [:show, :index]
    resources :purchases, shallow: true, except: [:show]
  end
  resources :users, except: [:new, :show]

  get '/signin', to: 'sessions#new', as: 'signin'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  get '/signup', to: 'users#new', as: 'signup'
  get '/home', to: 'users#show'

  root to: 'static#index'

end
