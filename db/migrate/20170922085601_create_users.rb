class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :username
      t.string :password_digest
      t.integer :roles, null: false
      t.timestamps
    end
  end
end
