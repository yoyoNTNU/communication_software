class AddColumnToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :isRead, :boolean
  end
end
