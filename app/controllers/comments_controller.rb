class CommentsController < ApplicationController
  private
  def search_params
    params.permit :place_id, :user_id, :page
  end

  def resource_params
    params.permit(:place_id, :text).merge user: current_user
  end

  def collection
    @collection ||= CommentSearcher.search(search_params).order :name
  end
end
