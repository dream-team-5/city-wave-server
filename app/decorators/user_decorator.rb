class UserDecorator < Draper::Decorator
  delegate_all

  def is_basic?
    model.roles? :basic
  end

  def is_registered?
    model.roles? :registered
  end

  def is_admin?
    model.roles? :admin
  end
end
