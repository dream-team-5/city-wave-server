class VisitedPlace
  include ActiveModel::Model

  delegate :as_json, to: :place

  attr_accessor :place_id

  validates :place_id, presence: true

  def initialize params
    @user = params[:user]

    @place_id = params[:place_id]
  end

  def save
    return false unless valid?

    !!(@user.visited_places << place)
  end

  private
  def place
    @place ||= Place.find place_id if place_id.present?
  end
end
