Rails.application.routes.draw do
  resource :profile, only: [:show, :create, :update]

  resource :session, only: :create
end
