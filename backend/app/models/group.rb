class Group < ApplicationRecord
    validates :count, :name, presence: true
    has_many :group_members,dependent: :destroy
    has_many :memberd, throught: :group_members
    mount_uploader :photo , GroupPhotoUploader
    mount_uploader :background , GroupBackUploader
end
