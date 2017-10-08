class TagPolicy < ApplicationPolicy
  def index?
    user.present?
  end
end
