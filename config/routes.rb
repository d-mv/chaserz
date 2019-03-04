Rails.application.routes.draw do

  devise_scope :user do
      authenticated :user do
        root :to => 'pages#menu'
        mount Sidekiq::Web => '/sidekiq'
      end

  unauthenticated :user do
    root :to =>'pages#home', as: :unauthenticated_root
  end

end

  mount ActionCable.server => '/cable'

  devise_for :users

  get '/menu', to: 'pages#menu'
  get '/ranks', to: 'pages#ranks'
  get '/map', to: 'races#map'

  resources :users, only: %i[show index] do
    resources :kits, only: %i[new create]
  end

  resources :kits, only: %i[edit update destroy]

  resources :races do
    resources :locations, only: %i[create]
    resources :participants, only: %i[create]
  end
  resources :participants, only: %i[update destroy]
  resources :locations, only: %i[update destroy]
end
