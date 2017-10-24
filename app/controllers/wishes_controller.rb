class WishesController < ApplicationController
  responds_to :json

  private
  def resource
    @resource ||= Wish.offset(rand(Wish.count)).first
  end
end
