class Admin::CategoriesController < ApplicationController
  responds_to :html, only: :index

  responds_to :js, except: :index

  private
  def resource_model
    Category
  end

  def resource_params
    params.require(:category).permit :name
  end
end
