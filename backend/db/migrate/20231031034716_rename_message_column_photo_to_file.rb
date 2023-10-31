class RenameMessageColumnPhotoToFile < ActiveRecord::Migration[7.0]
  def change
    rename_column :messages, :photo, :file
  end
end
