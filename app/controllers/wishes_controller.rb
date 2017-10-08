class WishesController < ApplicationController
  private
  def collection
    @collection ||= Wish.offset(rand(Wish.count)).first
  end
end
