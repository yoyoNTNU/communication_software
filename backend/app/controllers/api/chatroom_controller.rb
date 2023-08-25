class Api::ChatroomController < ApplicationController
  before_action :authenticate_member!

  def index
    @chatroom_list=ChatroomMember.where(member:current_member)
    @chatroom=[]
    @chatroom_list.each do |c|
      if !c.isDisabled
        temp=Chatroom.find(c.chatroom_id)
        if temp.type_=="group"
          g=Group.find(temp.type_id)
          count=ChatroomMember.where(chatroom:temp).length
          photo=g.photo
          name="#{g.name} (#{count})"
        elsif temp.type_=="friend"
          fs=Friendship.find(temp.type_id)
          friend=((Member.find(fs.member_id)==current_member)? Member.find(fs.friend_id): Member.find(fs.member_id))
          photo=friend.photo
          name= Friendship.find_by(member:current_member,friend:friend).nickname
        end
        message=Message.where(chatroom:temp).last
        isRead= MessageReader.find_by(message:message,member:current_member)? true:false;
        @chatroom<<{chatroom:temp,message:message,c_m:c,photo:photo,name:name,isRead:isRead}
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

end
