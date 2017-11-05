class Admin::PlacesController < ApplicationController
  responds_to :html, only: :index

  responds_to :js, except: :index

  private
  def resource_model
    Place
  end

  def resource_params
    params.require(:place).permit \
      :city_id, :category_id, :name, :description, :address, :latitude,
      :longitude, :contacts, :price, :photo, tag_ids: []
  end
end
