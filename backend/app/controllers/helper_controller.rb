class HelperController < ApplicationController
  def chatroomID_belongs_to
    c=Chatroom.find_by(id:params[:chatroom_id])
    if c
      if c.type_=="friend"
        f=Friendship.find_by(id:c.type_id)
        render json: {
          error: false,
          message: "succeed to get chatroom owner",
          data: {
            type: "friend",
            member_id_1: f.member_id,
            member_id_2: f.friend_id,
          }
        }.to_json, status: 200
      else
        render json: {
          error: false,
          message: "succeed to get chatroom owner",
          data: {
            type: "group",
            group_id: c.type_id,
          }
        }.to_json, status: 200
      end
    else
      render json: {
        error: true,
        message: "failed to get typeID",
        data: "This chatroom is not exist."
      }.to_json, status: 400
    end
  end

  def they_have_which_chatroom
    if(params[:type_]=="friend")
      friend1=Friendship.find_by(member_id:params[:member_id_1],friend_id:params[:member_id_2])
      friend2=Friendship.find_by(member_id:params[:member_id_2],friend_id:params[:member_id_1])
      c=Chatroom.find_by(type_:params[:type_],type_id:friend1.id)
      if c
        render json: {
          error: false,
          message: "succeed to get chatroomID",
          data: c
        }.to_json, status: 200
      else
        c=Chatroom.find_by(type_:params[:type_],type_id:friend2.id)
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
    else
      c=Chatroom.find_by(type_:params[:type_],type_id:params[:group_id])
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
end
