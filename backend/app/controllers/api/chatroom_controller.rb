class Api::ChatroomController < ApplicationController
  before_action :authenticate_member!

  def index
    @chatroom_list=ChatroomMember.where(member:current_member)
    @chatroom=[]
    @chatroom_list.each do |c|
      if !c.isDisabled
        temp=Chatroom.find(c.chatroom_id)
        message=Message.where(chatroom:temp).last
        @chatroom<<{chatroom:temp,message:message,c_m:c}
      end
    end
    @chatroom.sort_by!{ |hash| [hash[:c_m].isPinned ? 1 : 0, hash[:message].id]}.reverse!
    render json: {
      error: false,
      message: "succeed to get chatroom list",
      data: @chatroom
    }.to_json, status: 200
  end

end
