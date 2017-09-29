class AddIndexPlacesOnName < ActiveRecord::Migration[5.1]
  def change
    add_index :places, 'name gist_trgm_ops', using: 'gist'
  end
end
