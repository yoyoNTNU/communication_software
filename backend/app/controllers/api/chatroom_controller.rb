class Api::ChatroomController < ApplicationController
  before_action :authenticate_member!

  def index
    @chatroom_list=ChatroomMember.where(member:current_member)
    @chatroom=[]
    @chatroom_list.each do |c|
      if !c.isDisabled
        temp=Chatroom.find_by(id:c.chatroom_id)
        if temp.type_=="group"
          g=Group.find_by(id:temp.type_id)
          type_="group"
          count=ChatroomMember.where(chatroom:temp).length
          photo=g.photo
          name=g.name
        elsif temp.type_=="friend"
          fs=Friendship.find_by(id:temp.type_id)
          friend=((Member.find_by(id:fs.member_id)==current_member)? Member.find_by(id:fs.friend_id): Member.find_by(id:fs.member_id))
          photo=friend.photo
          type_="friend"
          count=nil
          name= Friendship.find_by(member:current_member,friend:friend).nickname
        end
        message=Message.where(chatroom:temp).last
        sender_id=message.member_id
        friendships=Friendship.find_by(member:current_member,friend_id:sender_id)
        if sender_id==current_member.id
          sender="您"
        elsif friendships.nil?
          sender= Member.find_by(id:sender_id).name 
        else
          sender=friendships.nickname
        end
        isRead= MessageReader.find_by(message:message,member:current_member)? true:false;
        @chatroom<<{chatroom:temp,message:message,c_m:c,photo:photo,name:name,isRead:isRead,chatroom_type:type_,count:count,sender:sender}
      end
    end
    @chatroom.sort_by!{ |hash| [hash[:c_m].isPinned ? 1 : 0, hash[:message].id]}.reverse!
    render json: {
      error: false,
      message: "succeed to get chatroom list",
      data: @chatroom
    }.to_json, status: 200
  end

  def update
    
  end

  def unread_count
    temp=ChatroomMember.find_by(member:current_member,chatroom_id:params[:chatroom_id])
    if temp
      message=Message.where(chatroom_id:params[:chatroom_id]).reverse
      count=0
      message.each do |m|
        if MessageReader.find_by(member:current_member,message:m).nil?
          p count
          count+=1
        else 
          break
        end
      end
      render json: {
        error: false,
        message: "succeed to get unread count",
        data: count
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to get unread count",
        data: "You aren't in this chatroom "
      }.to_json, status: 400
    end

  end


  def read

  end

  
end
