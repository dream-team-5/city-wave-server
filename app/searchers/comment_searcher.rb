class CommentSearcher < ApplicationSearcher
  private
  def initialize_results
    #
    # Either search by place id in /places/:id/comments or show user's comments
    #
    if @params[:place_id].blank?
      @results = @params[:user].comments
    else
      super
    end
  end

  def search_by_page page
    @results = @results.page page
  end

  def search_by_place_id place_id
    @results = @results.where place_id: place_id
  end
end
