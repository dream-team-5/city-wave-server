Rails.application.routes.draw do
  resources :categories, only: :index

  resources :cities, only: :index

  resource :profile, only: [:show, :create, :update]

  resource :session, only: :create

  resources :tags, only: :index

  resources :wishes, only: :index
end
