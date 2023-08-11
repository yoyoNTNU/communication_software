class FriendRequest < ApplicationRecord
  belongs_to :member
  belongs_to :friend, class_name: 'Member'
  before_create :set_default_content

  validate :not_self
  validate :not_friends
  validate :not_pending
  validate :sender_already_receive_invite
  private

  def set_default_content
    if content.blank?
      self.content= "#{self.friend.name}您好，我是#{self.member.name}，我想和您加個好友。"
    end
  end

  def not_self
    errors.add(:friend, "can't be equal to user") if member == friend
  end

  def not_friends
    errors.add(:friend, 'is already added') if member.friends.include?(friend)
  end

  def sender_already_receive_invite
    if FriendRequest.find_by(member: self.friend,friend: self.member)
      errors.add(:friend, 'already sent you friend request') 
    end
  end

  def not_pending
    if FriendRequest.find_by(member: self.member,friend: self.friend)
      errors.add(:friend, 'already requested friendship') 
    end
  end
end
