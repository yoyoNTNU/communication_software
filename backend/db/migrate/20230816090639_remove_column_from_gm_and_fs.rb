class RemoveColumnFromGmAndFs < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :isRead, :boolean
    remove_column :friendships, :background, :string
    remove_column :group_members, :background, :string
    remove_column :chatrooms, :isDisabled, :boolean
    remove_column :chatrooms, :isPinned, :boolean
  end
end
