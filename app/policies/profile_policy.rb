class ProfilePolicy < ApplicationPolicy
  def show?
    user.present? && user.basic?
  end

  def create?
    true
  end

  def update?
    user.present? && user.basic?
  end
end
