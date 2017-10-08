module AuthorizedController
  extend ActiveSupport::Concern

  included do
    include Pundit

    rescue_from(Pundit::NotAuthorizedError) do |e|
      render_error "not allowed to #{ e.query } #{ e.record.name }", 403
    end

    before_action -> { authorize resource }, except: :index

    before_action -> { authorize collection }, only: :index
  end
end
