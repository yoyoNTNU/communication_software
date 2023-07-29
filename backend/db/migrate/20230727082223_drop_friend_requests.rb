class DropFriendRequests < ActiveRecord::Migration[7.0]
  def change
    drop_table :friend_requests
  end
end
