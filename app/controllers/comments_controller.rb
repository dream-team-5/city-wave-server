class CommentsController < ApplicationController
  responds_to :json

  private
  def search_params
    params.permit(:place_id, :page).merge user: current_user
  end

  def resource_params
    params.permit(:place_id, :text).merge user: current_user
  end

  def collection
    @collection ||= CommentSearcher.search(search_params).order :id
  end
end
