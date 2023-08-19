class GroupMember < ApplicationRecord
    belongs_to :group
    belongs_to :member
    mount_uploader :background , GroupMemberUploader
end