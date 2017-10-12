class CommentDecorator < Draper::Decorator
  delegate_all

  def as_json options={}
    super options.reverse_merge only: [:id, :text, :created_at, :user_id, :place_id]
  end
end
