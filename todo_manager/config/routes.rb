Rails.application.routes.draw do
  root 'todos#index'
  post '/', to: 'todos#index'
  get 'todos/new'
  post 'todos/create'
  get 'todos/:id/detail', to: 'todos#detail'
  get 'todos/:id/edit', to: 'todos#edit'
  post 'todos/:id/update', to: 'todos#update'
  post 'todos/:id/destroy', to: 'todos#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
