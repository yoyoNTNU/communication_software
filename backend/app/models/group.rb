class Group < ApplicationRecord
	validates :name, presence: true
  after_create :create_chatroom
  after_destroy :destroy_chatroom
	mount_uploader :photo , GroupPhotoUploader
	mount_uploader :background , GroupBackUploader

	def self.get_groups(member)
		gs = GroupMember.where(member_id: member)
		groups = []

		gs.each do |g|
			temp = Group.find_by(id: g.group_id)
			groups << temp	
		end

		groups
	end


  private
  def create_chatroom 
    c=Chatroom.create(type_:"group",type_id:id)
  end

  def destroy_chatroom
    c=Chatroom.find_by(type_:"group",type_id:id)
    c.destroy if c
  end
	
end
