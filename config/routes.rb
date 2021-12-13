Rails.application.routes.draw do
root to: 'users#new'
resources :tasks
resources :users, only: %i(new create show)
resources :sessions, only: %i(new create destroy)
end
