class AddIsReplyToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :isReply, :boolean ,default: false
  end
end
