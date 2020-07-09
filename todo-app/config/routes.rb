Rails.application.routes.draw do
  resources :tasks

  root 'tasks#index'

  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
  patch '*not_found' => 'application#routing_error'
  delete '*not_found' => 'application#routing_error'

end
