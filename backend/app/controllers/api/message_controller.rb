class Api::MessageController < ApplicationController
  before_action :authenticate_member!

  def index
    @messages=Message.where(chatroom_id:params[:chatroom_id])
    render json: {
      error: false,
      message: "succeed to get all message in the chatroom",
      data: @messages
    }.to_json, status: 200
  end

  def show
    @message=Message.find_by(id:params[:id])
    render json: {
      error: false,
      message: "succeed to get message",
      data: @message
    }.to_json, status: 200
  end

  def create
    @message=Message.new(message_params)
    @message.chatroom_id=params[:chatroom_id]
    @message.member=current_member
    if @message.save
      render json: {
        error: false,
        message: "succeed to create message",
        data: @message
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to create message",
        data: @message.errors
      }.to_json, status: 400
    end
  end

  def destroy
    @message=Message.find_by(id:params[:id],member:current_member)
    if @message
      @message.destroy
      render json: {
        error: false,
        message: "succeed to delete message",
        data:{}
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to delete message",
        data: "This message is not exist or belong you."
      }.to_json, status: 400
    end
  end

  def update
    @message=Message.find_by(id:params[:id])
    if @message
      c_m=ChatroomMember.find_by(member:current_member,chatroom_id:@message.chatroom_id)
      if c_m
          if @message.update(message_params)
          render json: {
            error: false,
            message: "succeed to update message",
            data:@message
          }.to_json, status: 200
        else
          render json: {
            error: true,
            message: "failed to update message",
            data: @message.errors
          }.to_json, status: 400
        end
      else
        render json: {
          error: true,
          message: "failed to update message",
          data: "You are not in this chatroom."
        }.to_json, status: 400
      end
    else
      render json: {
        error: true,
        message: "failed to update message",
        data: "This message is not exist."
      }.to_json, status: 400
    end
  end

  def read
    @message=Message.find_by(id:params[:message_id])
    if @message
      m_r=MessageReader.create(member:current_member,message:@message)
      render json: {
        error: false,
        message: "succeed to read message",
        data: m_r
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to read message",
        data: "This message is not exist."
      }.to_json, status: 400
    end
  end

  def read_count
    @message=Message.find_by(id:params[:message_id])
    if @message
      count=MessageReader.where(message:@message).length
      render json: {
        error: false,
        message: "succeed to get message read count",
        data: count
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to get message read count",
        data: "This message is not exist."
      }.to_json, status: 400
    end
  end

  private

  def message_params
    params.permit(:type_, :content, :file, :isPinned, :reply_to_id, :isReply)
  end

end
