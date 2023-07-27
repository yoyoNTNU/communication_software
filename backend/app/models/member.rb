class Member < ApplicationRecord
    # Include default devise modules.
    extend Devise::Models
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
    include DeviseTokenAuth::Concerns::User
    validates_uniqueness_of :user_id,:phone
    validates :user_id, :name,:phone, presence: true
    validate :password_complexity
    has_many :friends ,dependent: :destroy
    has_many :messages ,dependent: :destroy
    has_many :group_members ,dependent: :destroy
    mount_uploader :photo , MemberPhotoUploader
    mount_uploader :background , MemberBackUploader

    def password_complexity
      # Configure Password Complexity Requirements
      if password.present? && !password.match?(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]+$/)
        errors.add(:password, "at least one uppercase, lowercase letter, number and can not include other special character")
      end
    end

    def remove_friend(friend)
      current_member.friends.destroy(friend)
    end
end
