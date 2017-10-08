class SessionDecorator < Draper::Decorator
  delegate_all

  delegate :to_json, to: :auth_token
end
