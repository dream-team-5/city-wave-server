class CityPolicy < ApplicationPolicy
  def index?
    user.present?
  end
end
