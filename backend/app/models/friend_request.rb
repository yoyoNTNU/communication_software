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
    if member.friend_requests.find_by(friend: friend)
      errors.add(:friend, 'already requested friendship') 
    end
  end
end