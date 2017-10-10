class WishPolicy < ApplicationPolicy
  def index?
    user.present? && user.basic?
  end
end
