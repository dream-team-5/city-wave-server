class WishPolicy < ApplicationPolicy
  def index?
    user.present?
  end
end
