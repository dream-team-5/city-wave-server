class Api::SessionPolicy < ApplicationPolicy
  def create?
    true
  end
end
