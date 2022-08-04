Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :tasks
  resources :users, only: %i(show)
  resources :categories, only: %i(index create destroy edit update)
  root 'tasks#index'
end
