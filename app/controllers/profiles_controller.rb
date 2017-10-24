class ProfilesController < ApplicationController
  responds_to :json

  skip_before_action :authenticate, only: :create

  private
  def create_resource_params
    nil
  end

  def update_resource_params
    params.permit :password, :username
  end

  def resource
    @resource ||= Profile.new current_user
  end
end
