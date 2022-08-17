Rails.application.routes.draw do
  get 'admin/index'
  get 'admin/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :tasks
  resources :users
  resources :categories, only: %i(index create destroy edit update)
  resources :account_activations, only: :edit

  root 'sessions#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get    '/admin',   to: 'users#index'
  post   '/admin',   to: 'users#create'
  delete '/admin',   to: 'users#destroy'
end
