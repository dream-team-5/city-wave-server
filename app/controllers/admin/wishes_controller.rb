class Admin::WishesController < ApplicationController
  responds_to :html, only: :index

  responds_to :js, except: :index

  private
  def resource_model
    Wish
  end

  def resource_params
    params.require(:wish).permit :text
  end
end
