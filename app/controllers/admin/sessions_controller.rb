class Admin::SessionsController < ApplicationController
  responds_to :html, :js

  skip_before_action :authenticate, only: [:new, :create]

  after_action :login_user, only: :create

  private
  alias_method :resource, :resource_model

  def resource_params
    params.require(:admin_session).permit :username, :password
  end

  def create_success_callback
    respond_to do |format|
      format.html { redirect_to action: :show }

      format.all { render }
    end
  end

  def login_user
    session[:token] = resource.auth_token if resource.persisted?
  end
end
