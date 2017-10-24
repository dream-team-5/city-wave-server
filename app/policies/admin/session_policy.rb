class Admin::SessionPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    user.present? && user.admin?
  end
end
