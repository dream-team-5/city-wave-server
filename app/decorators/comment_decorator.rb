class CommentDecorator < Draper::Decorator
  delegate_all

  delegate :username, to: :user

  def as_json options={}
    super options.reverse_merge \
      only: [:id, :text, :created_at, :place_id],
      methods: [:username]
  end
end
