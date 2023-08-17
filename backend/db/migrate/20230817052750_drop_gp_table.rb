class DropGpTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :group_members
  end
end
