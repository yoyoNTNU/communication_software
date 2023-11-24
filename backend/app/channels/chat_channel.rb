class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom_#{params[:chatroom_id]}"
  end

  def unsubscribed
  end

  def receive(data)
    # current action: ["send_string_msg","send_file_msg","delete_msg","set_announcement","delete_announcement"]
    # maybe need action:["inputing"]
    case data['action']  
    when "send_string_msg"
      chatroom_id=data['chatroom_id']
      channel_name = "chatroom_#{chatroom_id}"
      m=Message.create(
        chatroom_id:chatroom_id,
        member_id:data['member_id'],
        type_:data['type_'],
        content:data['content'],
        isReply: data['isReply'],
        reply_to_id:data['reply_to_id']
      )
    when "send_file_msg"
      m=Message.find_by(id:data['messageID'])
    end  
      ActionCable.server.broadcast(channel_name, { message: {
        "messageID": m.id,
        "senderID": m.member_id,
        "type": m.type_,
        "content": m.type_=="string" ? m.content : m.file,
        "msgTime": m.created_at,
        "isReply": m.isReply,
        "replyToID": m.reply_to_id,
        "isPinned": m.isPinned,
        "updatedAt": m.updated_at,
      } })
      chatroom_members=ChatroomMember.where(chatroom_id:m.chatroom_id)
      MessageReader.create(message:m,member:m.member)
      chatroom_members.each do |c|
        c.isDisabled=false
        c.save
      
    end
  end
end
