Rails.application.routes.draw do
  resources :categories, only: :index do
    resources :places, only: :index
  end

  resources :cities, only: :index do
    resources :places, only: :index
  end

  resources :places, only: :show

  resource :profile, only: [:show, :create, :update]

  resource :session, only: :create

  resources :tags, only: :index do
    resources :places, only: :index
  end

  resources :wishes, only: :index
end
