Rails.application.routes.draw do
  resources :tasks
  root to: 'tasks#index'

  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
end
