class AddAttachmentPhotoToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_attachment :places, :photo
  end
end
