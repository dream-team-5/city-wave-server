class Admin::SessionsController < ApplicationController
  responds_to :html

  skip_before_action :authenticate, only: [:new, :create]

  after_action :login_user, only: :create

  private
  def resource
    @resource ||= resource_model
  end

  def resource_params
    params.require(:admin_session).permit :username, :password
  end

  def create_success_callback
    redirect_to action: :show
  end

  def login_user
    session[:token] = resource.auth_token if resource.persisted?
  end
end
