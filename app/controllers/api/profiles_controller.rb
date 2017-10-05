class Api::ProfilesController < ApplicationController
  skip_before_action :authenticate, only: :create

  private
  def create_resource_params
    nil
  end

  def update_resource_params
    params.permit :password, :username, :new_password
  end

  def resource
    @resource ||= Api::Profile.new current_user
  end
end
