Rails.application.routes.draw do
  resources :tasks
  get '*path', controller: 'application', action: 'render_404'
end
