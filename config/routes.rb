Rails.application.routes.draw do
  resources :cities, only: :index

  resource :profile, only: [:show, :create, :update]

  resource :session, only: :create

  resources :tags, only: :index
end
