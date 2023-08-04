class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.references :member, null: false, foreign_key: { to_table: :members }
      t.references :friend, null: false, foreign_key: { to_table: :members }
      t.string :nickname
      t.string :background #朋友聊天室背景
      t.timestamps
    end
  end
end
