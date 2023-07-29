class AddNicknameAndBackgroundToFriendships < ActiveRecord::Migration[7.0]
  def change
    add_column :friendships, :nickname, :string
    add_column :friendships, :background, :string
  end
end
