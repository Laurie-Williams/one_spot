Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'hello_world#index'
  resources :accounts, only: [:new, :create, :show]
  resources :cases, only: [:new, :create, :index]
end
