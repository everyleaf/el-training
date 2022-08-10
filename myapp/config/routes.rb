Rails.application.routes.draw do
  get '/', to:'tasks#list'
  get 'tasks/new'
  post 'tasks/create'
  patch 'tasks/update/:id', to:'tasks#update', as:'tasks_update'
  get 'tasks/details/:id', to:'tasks#show', as:'tasks_details'
  get 'tasks/edit/:id', to:'tasks#edit', as:'tasks_edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
