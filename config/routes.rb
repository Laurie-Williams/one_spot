Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'hello_world#index'
  resources :accounts, only: [:new, :create]
  devise_for :users

  constraints(SubdomainRequired) do
    scope module: :owned, as: :owned do
      resources :accounts, only: [:show]
      resources :cases, only: [:new, :create, :index]
    end
  end

  # Use letter_opener_web gem to view sent emails in dev env
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
