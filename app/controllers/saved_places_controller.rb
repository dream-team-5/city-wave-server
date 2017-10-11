class SavedPlacesController < ApplicationController
  private
  def collection
    @collection ||= current_user.saved_places
  end

  def resource_params
    params.permit(:place_id).merge user: current_user
  end
end
