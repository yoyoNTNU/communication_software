class Friendship < ApplicationRecord
  before_create :set_default_nickname
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  belongs_to :member
  belongs_to :friend, class_name: 'Member'
  validates :friend, uniqueness: { scope: :member }
  validate :not_self

  private
  def not_self
    errors.add(:friend, "can't be equal to user") if member == friend
  end

  def create_inverse_relationship
    friend.friendships.create(friend: member)
  end

  def destroy_inverse_relationship
    friendship = friend.friendships.find_by(friend: member)
    friendship.destroy if friendship
  end

  def set_default_nickname
    self.nickname=Member.find(self.friend_id).name
  end
end
