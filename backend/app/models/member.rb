class Member < ApplicationRecord
    # Include default devise modules.
    extend Devise::Models
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
    include DeviseTokenAuth::Concerns::User
    validates_uniqueness_of :user_id,:phone
    validates :user_id, :name, :phone, presence: true
    validate :password_complexity
    has_many :friend_requests, dependent: :destroy
    has_many :pending_friends, through: :friend_requests, source: :friend
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships
    has_many :messages ,dependent: :destroy
    has_many :groups , through: :group_members
    has_many :chatroom_members,dependent: :destroy
    has_many :message_readers, dependent: :destroy
    mount_uploader :photo , MemberPhotoUploader
    mount_uploader :background , MemberBackUploader

    def password_complexity
      # Configure Password Complexity Requirements
      if password.present? && !password.match?(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]+$/)
        errors.add(:password, "at least one uppercase, lowercase letter, number and can not include other special character")
      end
    end
end
