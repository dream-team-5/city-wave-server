class RemoveDateFromComments < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :date
  end
end
