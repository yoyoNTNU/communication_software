class ChatChannel < ApplicationCable::Channel
  #TODO:Action Cable設定
  def subscribed
    stream_from "chat_#{params[:chat_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
