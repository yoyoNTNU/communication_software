class Member < ApplicationRecord
    # Include default devise modules.
    extend Devise::Models
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
    include DeviseTokenAuth::Concerns::User
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
        errors.add(:password, "at least one uppercase, lowercase letter and one number and can not include other character")
      end
    end
end
