class ChangeDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :chatrooms, :isDisabled, from: nil, to: false
    change_column_default :chatrooms, :isPinned,   from: nil, to: false
    change_column_default :messages,  :isPinned,   from: nil, to: false
    change_column_default :messages,  :isRead,     from: nil, to: false
    add_reference :messages, :reply_to, foreign_key: { to_table: :messages }
  end
end
