class UserDecorator < Draper::Decorator
  delegate_all

  def basic?
    model.roles? :basic
  end

  def registered?
    model.roles? :registered
  end

  def admin?
    model.roles? :admin
  end
end
