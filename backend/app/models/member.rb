class Member < ApplicationRecord
    validates :user_id, :birthday, :email, :password, :name,:phone, presence: true
    has_many :friends ,dependent: :destroy
    has_many :messages ,dependent: :destroy
    has_many :group_members ,dependent: :destroy
end
