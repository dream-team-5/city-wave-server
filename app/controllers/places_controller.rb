class PlacesController < ApplicationController
  private
  def search_params
    params.permit :category_id, :city_id, :tag_id, :page, :name
  end

  def collection
    @collection ||= PlaceSearcher.search(search_params).order :name
  end
end
