class Group < ApplicationRecord
    validates :count, :name, presence: true
    has_many :group_members,dependent: :destroy
end
