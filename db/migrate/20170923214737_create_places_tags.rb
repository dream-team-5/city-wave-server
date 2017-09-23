class CreatePlacesTags < ActiveRecord::Migration[5.1]
  def change
    create_table :places_tags do |t|
      t.belongs_to :place, foreign_key: true
      t.belongs_to :tag, foreign_key: true
      t.timestamps
    end
  end
end
