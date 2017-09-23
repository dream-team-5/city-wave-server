class CreateVisitedPlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :visited_places do |t|
      t.belongs_to :place, foreign_key: true
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
