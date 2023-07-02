class Chatroom < ApplicationRecord
    validates :type, :type_id, presence: true
    has_many :messages,dependent: :destroy
end
