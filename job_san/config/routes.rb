Rails.application.routes.draw do
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :tasks
  namespace :admin do
    resources :users, controller: 'users', only: %i[index create new edit update destroy] do
      member do
        get 'tasks', action: 'user_tasks'
      end
    end

    resources :labels, only: %i[index create new edit update destroy]
  end
  get '*path', controller: 'application', action: 'render_404'
end
