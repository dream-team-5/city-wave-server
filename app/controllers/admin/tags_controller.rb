class Admin::TagsController < ApplicationController
  responds_to :html, only: :index

  responds_to :js, except: :index

  private
  def resource_model
    Tag
  end

  def resource_params
    params.require(:tag).permit :name
  end
end
