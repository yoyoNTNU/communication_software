class ChatroomMember < ApplicationRecord
  belongs_to :chatroom
  belongs_to :member
  mount_uploader :background , ChatroomMemberUploader
  before_destroy :remove_cloud_img
  after_destroy :check_groupmember_count

  private
  def remove_cloud_img
    if self.background.url.nil?
      self.remove_background! 
      self.save
    end
  end

  def check_groupmember_count
    c=Chatroom.find(chatroom_id)
    if c.type_=="group"
      if !ChatroomMember.find_by(chatroom:c)
        Group.find(c.type_id).destroy
      end
    end
  end

end
