class AddSentEmailColumnToMember < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :is_login_mail, :boolean, default:true
  end
end
