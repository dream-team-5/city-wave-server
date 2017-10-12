class CommentSearcher < ApplicationSearcher
  private
  def search_by_page page
    @results = @results.page page
  end

  def search_by_place_id place_id
    @results = @results.where place_id: place_id
  end

  def search_by_user_id user_id
    @results = @results.where user_id: user_id
  end
end
