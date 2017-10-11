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

  def as_json options={}
    super options.reverse_merge only: [:id, :username, :roles]
  end
end
