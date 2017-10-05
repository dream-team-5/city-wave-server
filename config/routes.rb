Rails.application.routes.draw do
  namespace :api do
    resource :profile, only: [:show, :create, :update]
  end
end
