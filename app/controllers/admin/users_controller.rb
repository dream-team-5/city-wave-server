class Admin::UsersController < ApplicationController
  responds_to :html, only: :index

  responds_to :js, except: :index

  private
  def resource_model
    User
  end

  def resource_params
    params.require(:user).permit :username, :password, roles: []
  end
end
