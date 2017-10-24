class SessionsController < ApplicationController
  responds_to :json

  skip_before_action :authenticate, only: :create

  private
  def resource_params
    params.permit :username, :password
  end
end
