Rails.application.routes.draw do
  get 'categories/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :tasks

  resources :categories, only: %i(index create destroy)
  root 'tasks#index'
end
