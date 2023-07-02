class CreateChatrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chatrooms do |t|
      t.string :type #friend or group
      t.integer :type_id
      t.timestamps
    end
  end
end
