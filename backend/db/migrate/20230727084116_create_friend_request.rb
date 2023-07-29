class CreateFriendRequest < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.references :member, null: false, foreign_key: { to_table: :members }
      t.references :friend, null: false, foreign_key: { to_table: :members }
      t.string :content

      t.timestamps
    end
  end
end
