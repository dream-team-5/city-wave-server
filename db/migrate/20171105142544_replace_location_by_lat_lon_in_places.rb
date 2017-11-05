class ReplaceLocationByLatLonInPlaces < ActiveRecord::Migration[5.1]
  def change
    remove_column :places, :location

    add_column :places, :latitude, :float

    add_column :places, :longitude, :float
  end
end
