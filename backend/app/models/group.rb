class Group < ApplicationRecord
	validates :name, presence: true
	has_many :group_members,dependent: :destroy
	has_many :members, through: :group_members
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

	
end
