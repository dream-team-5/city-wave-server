Rails.application.routes.draw do
  namespace :api do
    resource :profile, only: [:show, :create, :update]

    resource :session, only: :create
  end
end
