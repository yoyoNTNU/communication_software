class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.integer :user_id
      t.string :photo
      t.string :background #個人檔案背景
      t.date :birthday
      t.string :introduction
      t.string :email
      t.string :password
      t.string :name
      t.string :phone

      t.timestamps
    end
  end
end
