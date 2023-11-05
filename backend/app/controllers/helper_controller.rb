class HelperController < ApplicationController
  def from_chatroomID_to_typeID
    c=Chatroom.find_by(id:params[:chatroom_id])
    if c
      render json: {
        error: false,
        message: "succeed to get typeID",
        data: c
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to get typeID",
        data: "This chatroom is not exist."
      }.to_json, status: 400
    end
  end

  def from_typeID_to_chatroomID
    c=Chatroom.find_by(type_:params[:type_],type_id:params[:type_id])
    if c
      render json: {
        error: false,
        message: "succeed to get chatroomID",
        data: c
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to get chatroomID",
        data: "This chatroom is not exist."
      }.to_json, status: 400
    end
  end
end
