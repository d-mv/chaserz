Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  resources :users, only: %i[show index] do
    resources :kits, only: %i[new create]
  end

  resources :kits, only: %i[edit update destroy]

  resources :races do
    resources :locations, only: %i[create]
    resources :checkpoints, only: %i[create]
    resources :participants, only: %i[create]
  end

  resources :checkpoints, only: %i[update destroy]
  resources :participants, only: %i[update destroy]
  resources :locations, only: %i[update destroy]
end