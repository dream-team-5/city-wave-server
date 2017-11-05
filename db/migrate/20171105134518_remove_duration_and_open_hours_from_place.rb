class RemoveDurationAndOpenHoursFromPlace < ActiveRecord::Migration[5.1]
  def change
    remove_column :places, :duration

    remove_column :places, :open_hours
  end
end
