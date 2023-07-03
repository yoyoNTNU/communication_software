class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.belongs_to :chatroom , null: false, foreign_key: true
      t.belongs_to :member , null: false, foreign_key: true
      t.string :type #string or photo
      t.text :content
      t.string :photo
      t.boolean :isPinned
      t.timestamps
    end
  end
end
