Rails.application.routes.draw do
  get '/' => 'todos#index'
	get 'todos/new'
	post 'todos/create'
	get 'todos/:id/detail' => 'todos#detail'
	get 'todos/:id/edit' => 'todos#edit'
	post 'todos/:id/update' => 'todos#update'
	post 'todos/:id/destroy' => 'todos#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
