class ProfileDecorator < Draper::Decorator
  delegate_all

  def to_json
    { id: user_id, username: user_username }.to_json
  end
end
