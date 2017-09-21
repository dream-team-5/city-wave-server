module AuthorizedController
  extend ActiveSupport::Concern

  included do
    include Pundit

    rescue_from(Pundit::NotAuthorizedError) { head :forbidden }

    before_action -> { authorize resource }, except: :index

    before_action -> { authorize collection }, only: :index
  end
end
