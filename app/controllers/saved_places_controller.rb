class SavedPlacesController < ApplicationController
  responds_to :json

  private
  def collection
    @collection ||= SavedPlaceSearcher.search(search_params).order :name
  end

  def resource_params
    params.permit(:place_id).merge user: current_user
  end

  def search_params
    params.permit(:page, :name).merge user: current_user
  end
end
