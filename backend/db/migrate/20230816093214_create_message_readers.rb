class CreateMessageReaders < ActiveRecord::Migration[7.0]
  def change
    create_table :message_readers do |t|
      t.belongs_to :member , null: false, foreign_key: true
      t.belongs_to :message , null: false, foreign_key: true

      t.timestamps
    end
  end
end
