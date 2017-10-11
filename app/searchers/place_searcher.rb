class PlaceSearcher < ApplicationSearcher
  private
  def search_by_category_id category_id
    @results = @results.joins(:category).where(categories: { id: category_id })
  end

  def search_by_tag_id tag_id
    @results = @results.joins(:tags).where(tags: { id: tag_id })
  end

  def search_by_city_id city_id
    @results = @results.joins(:city).where(cities: { id: city_id })
  end

  def search_by_page page
    @results = @results.page page
  end

  def search_by_name name
    @results = @results.search_by_name name
  end
end
