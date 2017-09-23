class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.belongs_to :place, foreign_key: true
      t.string :text, null: false
      t.date :date, null: false
      t.timestamps
    end
  end
end
