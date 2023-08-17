class Friendship < ApplicationRecord
  before_create :set_default_nickname
  after_create :create_chatroom
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship
  after_destroy :destroy_chatroom

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

  def create_chatroom
    f=Friendship.find_by(member:friend,friend:member)
    if f && Chatroom.find_by(type_:"friend",type_id:f.id)
      c=Chatroom.find_by(type_:"friend",type_id:f.id)
    else 
      c=Chatroom.create(type_:"friend",type_id:id)
    end
    ChatroomMember.create(member:member,chatroom_id:c.id)
  end

  def destroy_inverse_relationship
    friendship = friend.friendships.find_by(friend: member)
    friendship.destroy if friendship
  end

  def destroy_chatroom
    c=Chatroom.find_by(type_:"friend",type_id:id)
    c.destroy if c
  end

  def set_default_nickname
    self.nickname=Member.find(self.friend_id).name
  end
end
