class SavedPlacePolicy < ApplicationPolicy
  def index?
    user.present? && user.basic?
  end

  def create?
    user.present? && user.basic?
  end
end
