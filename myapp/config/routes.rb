Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tasks#index"

  resources :tasks

  # overrirde default error pages
  get '/404', to: 'errors#not_found', as: :not_found, via: :all
  get '/500', to: 'errors#internal_server_error', as: :internal_server_error, via: :all

  get '/errors/:status', to: 'errors#show', as: :error

  match '*path', to: 'errors#not_found', via: :all
end
