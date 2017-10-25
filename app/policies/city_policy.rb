class CityPolicy < ApplicationPolicy
  def index?
    user.present? && user.basic?
  end

  def admin?
    user.present? && user.admin?
  end

  alias_method :show?, :admin?

  alias_method :create?, :admin?

  alias_method :update?, :admin?

  alias_method :destroy?, :admin?
end
