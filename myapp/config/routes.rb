Rails.application.routes.draw do
  resources :tasks
  root to: 'tasks#index'
end
