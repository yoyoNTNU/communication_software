class Member < ApplicationRecord
    # Include default devise modules.
    extend Devise::Models
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
    include DeviseTokenAuth::Concerns::User
    validates :user_id, :birthday, :name,:phone, presence: true
    has_many :friends ,dependent: :destroy
    has_many :messages ,dependent: :destroy
    has_many :group_members ,dependent: :destroy
    mount_uploader :photo , MemberPhotoUploader
    mount_uploader :background , MemberBackUploader
end
