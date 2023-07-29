class Friendship < ApplicationRecord
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  belongs_to :member
  belongs_to :friend, class_name: 'Member'
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :member }
  validate :not_self
  mount_uploader :background , FriendUploader

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
end
