class CategoryPolicy < ApplicationPolicy
  def index?
    user.present? && user.basic?
  end
end
