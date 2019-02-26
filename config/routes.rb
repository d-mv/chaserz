Rails.application.routes.draw do

  devise_scope :user do
      authenticated :user do
        root :to => 'pages#menu'
      end

  unauthenticated :user do
    root :to =>'pages#home', as: :unauthenticated_root
  end

end
  devise_for :users

  get '/menu', to: 'pages#menu'
  get '/ranks', to: 'pages#ranks'

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
