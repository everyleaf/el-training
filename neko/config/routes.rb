Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tasks
  root 'tasks#index'
  unless Rails.env.development?
    get '*path', to: 'application#render404'
  end
end
