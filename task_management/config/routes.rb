Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  get '*path', to: 'application#render404'
end
