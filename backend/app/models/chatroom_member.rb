class ChatroomMember < ApplicationRecord
  belongs_to :group
  belongs_to :member
  mount_uploader :background , ChatroomMemberUploader
end
