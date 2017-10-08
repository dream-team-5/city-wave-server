class ProfileDecorator < Draper::Decorator
  delegate_all

  def id
    user_id
  end

  def username
    user_username
  end

  def attributes
    { "id" => user_id, "username" => user_username }
  end
end
