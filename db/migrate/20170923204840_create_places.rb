class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.belongs_to :city, foreign_key: true
      t.belongs_to :category, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false
      t.string :address, null: false
      t.point :location, null: false
      t.string :contacts
      t.decimal :price
      t.tstzrange :open_hours
      t.daterange :duration
      t.timestamps
    end
  end
end
