Rails.application.routes.draw do
  resources :tasks
  get '/', to:'tasks#index'
  post 'tasks', to:'tasks#create', as:'create_task'
  delete 'tasks/:id', to:'tasks#delete', as:'delete_task'
  patch 'tasks/:id', to:'tasks#update', as:'update_task'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
