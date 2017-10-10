class CityPolicy < ApplicationPolicy
  def index?
    user.present? && user.basic?
  end
end
