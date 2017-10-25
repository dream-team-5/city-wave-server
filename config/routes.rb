Rails.application.routes.draw do
  resources :categories, only: :index do
    resources :places, only: :index
  end

  resources :cities, only: :index do
    resources :places, only: :index
  end

  resources :comments, only: :index

  resources :places, only: :show do
    resources :comments, only: [:index, :create]
  end

  resource :profile, only: [:show, :create, :update]

  resources :saved_places, only: [:index, :create]

  resource :session, only: :create

  resources :tags, only: :index do
    resources :places, only: :index
  end

  resources :visited_places, only: [:index, :create]

  resource :wish, only: :show

  namespace :admin do
    root action: :show, controller: :sessions

    resource :session, only: [:new, :create, :show]

    resources :categories

    resources :cities

    resources :tags

    resources :users

    resources :wishes
  end
end
