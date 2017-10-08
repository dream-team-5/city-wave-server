class CategoryPolicy < ApplicationPolicy
  def index?
    user.present?
  end
end
