class CreateFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.belongs_to :member , null: false, foreign_key: true
      t.integer :friend_id
      t.string :nickname
      t.timestamps
    end
  end
end
