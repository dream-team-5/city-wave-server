class PlacePolicy < ApplicationPolicy
  def index?
    user.present? && user.basic?
  end

  def show?
    user.present? && user.basic?
  end
end
