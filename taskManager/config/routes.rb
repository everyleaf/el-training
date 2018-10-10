Rails.application.routes.draw do
  resources :task_labels
  resources :labels
  resources :tasks
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
