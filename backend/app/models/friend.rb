class Friend < ApplicationRecord
    validates :friend_id, :nickname, presence: true
    belongs_to :member
end
