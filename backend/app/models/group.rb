class Group < ApplicationRecord
    validates :count, :name, presence: true
    has_many :group_members,dependent: :destroy
    mount_uploader :photo , GroupPhotoUploader
    mount_uploader :background , GroupBackUploader
end
