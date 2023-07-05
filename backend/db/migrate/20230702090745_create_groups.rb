class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :photo
      t.string :background #個人設定的群組聊天室背景
      t.timestamps
    end
  end
end
