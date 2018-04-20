Rails.application.routes.draw do
  get 'todos/index'
	get 'todos/new'
	post 'todos/create'
	get 'todos/:id/detail' => 'todos#detail'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
