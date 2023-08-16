class CreateChatroomMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :chatroom_members do |t|
      t.belongs_to :member , null: false, foreign_key: true
      t.belongs_to :chatroom , null: false, foreign_key: true
      t.string :background #個人設定聊天背景
      t.boolean :isPinned ,default:false #個人是否置頂此聊天室
      t.boolean :isDisabled ,default:true #個人是否隱藏此聊天室
      t.boolean :isMuted , default:false #個人是否靜音此聊天室
      t.datetime :delete_at #何時刪除此聊天室
      t.timestamps
    end
  end
end
