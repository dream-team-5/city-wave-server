class CommentPolicy < ApplicationPolicy
  def index?
    user.present? && user.basic?
  end

  def create?
    user.present? && user.registered?
  end
end
