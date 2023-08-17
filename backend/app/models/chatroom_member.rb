class ChatroomMember < ApplicationRecord
  belongs_to :chatroom
  belongs_to :member
  mount_uploader :background , ChatroomMemberUploader
  after_destroy :check_groupmember_count

  private

  def check_groupmember_count
    c=Chatroom.find(chatroom_id)
    if c.type_=="group"
      if !ChatroomMember.find_by(chatroom:c)
        Group.find(c.type_id).destroy
      end
    end
  end

end
