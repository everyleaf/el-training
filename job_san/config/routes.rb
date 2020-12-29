Rails.application.routes.draw do
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :tasks
  namespace :admin do
    resources :users, controller: 'users', only: [:index, :create, :new, :edit, :update, :destroy] do
      member do
        get 'tasks', action: 'user_tasks'
      end
    end

  end
  get '*path', controller: 'application', action: 'render_404'
end
