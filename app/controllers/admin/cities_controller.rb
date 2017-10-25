class Admin::CitiesController < ApplicationController
  responds_to :html, only: :index

  responds_to :js, except: :index

  private
  def resource_model
    City
  end

  def resource_params
    params.require(:city).permit :name
  end
end
