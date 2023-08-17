class CreateGroupMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :group_members do |t|
      t.belongs_to :member , null: false, foreign_key: true
      t.belongs_to :group , null: false, foreign_key: true
      t.string :background #個人設定的群組聊天室背景
      t.timestamps
    end
  end
end
