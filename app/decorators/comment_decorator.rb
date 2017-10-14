class CommentDecorator < Draper::Decorator
  delegate_all

  def as_json options={}
    super(options.reverse_merge only: [:id, :text, :created_at, :place_id])
      .merge 'username' => user.username
  end
end
