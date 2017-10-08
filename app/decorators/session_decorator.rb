class SessionDecorator < Draper::Decorator
  delegate_all

  delegate :as_json, to: :auth_token
end
