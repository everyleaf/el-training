Rails.application.routes.draw do
  root 'sessions#new'

  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :tasks

  get 'api/tasks/search' => 'api/tasks#search'
  post 'api/tasks' => 'api/tasks#create'
  put 'api/tasks/:id' => 'api/tasks#update'
  delete 'api/tasks/:id' => 'api/tasks#destroy'
  delete 'api/logout' => 'api/sessions#destroy'

  namespace :admin do
    resources :users, controller: 'users', only: [:index, :create, :new, :edit, :update, :destroy] do
      member do
        get 'tasks', action: 'user_tasks'
      end
    end
  end

  get '*path', controller: 'application', action: 'render_404'
end
