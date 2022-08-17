Rails.application.routes.draw do
  get '/', to:'tasks#list', as:'tasks'
  get 'tasks/new'
  post 'tasks/create'
  patch 'tasks/update/:id', to:'tasks#update', as:'tasks_update'
  delete 'tasks/delete/:id', to:'tasks#delete', as:'tasks_delete'
  get 'tasks/details/:id', to:'tasks#show', as:'tasks_details'
  get 'tasks/edit/:id', to:'tasks#edit', as:'tasks_edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
