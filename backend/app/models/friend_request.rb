class FriendRequest < ApplicationRecord
  belongs_to :member
  belongs_to :friend, class_name: 'Member'

  validate :not_self
  validate :not_friends
  validate :not_pending
  private

  def not_self
    errors.add(:friend, "can't be equal to user") if member == friend
  end

  def not_friends
    errors.add(:friend, 'is already added') if member.friends.include?(friend)
  end

  def not_pending
    errors.add(:friend, 'already requested friendship') if friend.pending_friends.include?(member)
  end
end
