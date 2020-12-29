Rails.application.routes.draw do
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :tasks
  get '*path', controller: 'application', action: 'render_404'
end
