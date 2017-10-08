class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  private
  def resource_params
    params.permit :username, :password
  end
end
