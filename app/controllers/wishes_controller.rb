class WishesController < ApplicationController
  private
  def resource
    @resource ||= Wish.offset(rand(Wish.count)).first
  end
end
