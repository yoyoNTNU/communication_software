class AddColumnToChatroom < ActiveRecord::Migration[7.0]
  def change
    add_column :chatrooms, :isDisabled, :boolean
    add_column :chatrooms, :isPinned, :boolean
  end
end
