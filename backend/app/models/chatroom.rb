class Chatroom < ApplicationRecord
    validates :type_, :type_id, presence: true
    has_many :messages,dependent: :destroy
    has_many :chatroom_members,dependent: :destroy
end
