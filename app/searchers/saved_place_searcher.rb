class SavedPlaceSearcher < ApplicationSearcher
  private
  def initialize_results
    @results = @params[:user].saved_places
  end

  def search_by_page page
    @results = @results.page page
  end

  def search_by_name name
    @results = @results.search_by_name name
  end
end
