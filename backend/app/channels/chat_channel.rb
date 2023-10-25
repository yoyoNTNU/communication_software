class ChatChannel < ApplicationCable::Channel
  #TODO:Action Cable設定
  def subscribed
    stream_from "chatroom_#{params[:chatroom_id]}"
  end

  def unsubscribed
  end

  def receive(data)
    chatroom_id=data['chatroom_id']
    channel_name = "chatroom_#{chatroom_id}"
    message = data
    ActionCable.server.broadcast(channel_name, { message: data })
  end

  
end
