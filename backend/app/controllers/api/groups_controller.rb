class Api::GroupsController < ApplicationController
  before_action :authenticate_member! ,except: [:show,:member_list]
  def index
    @chatroom=ChatroomMember.where(member:current_member)
    @group=[]
    @chatroom.each do |c|
      temp=Chatroom.find_by(id:c.chatroom_id,type_:"group")
      if temp
        @group<<temp
      end
    end
    render json: {
      error: false,
      message: "succeed to get groups respect to current member",
      data: @group
    }.to_json, status: 200
  end

  def show
    @group = Group.find_by(id:params[:id])
    if @group
      render json: {
        error: false,
        message: "succeed to get group",
        data: @group
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to get group",
        data: "group isn't exist"
      }.to_json, status: 400
    end
  end

  def member_list
    chatroom=Chatroom.find_by(type_:"group",type_id:params[:group_id])
    if chatroom.nil?
      render json: {
        error: true,
        message: "failed to get group member list",
        data: "group isn't exist"
      }.to_json, status: 400
    else 
      member_list= ChatroomMember.where(chatroom_id:chatroom.id)
      @member_id_list=[]
      member_list.each do |m|
        @member_id_list<<m.member_id
      end
      render json: {
        error: false,
        message: "succeed to get group member list",
        data: {
          count:@member_id_list.length,
          member:@member_id_list
        }
      }.to_json, status: 200
    end
  end

  #可邀請人員列表(朋友列表-已在群組人員)、更新資料
  
  def create
    #只有創建群組的人要在建立群組時建立CM，其他人等邀請的時候寫在controller
    @group = Group.new(group_params)
    if @group.save
      temp=Chatroom.find_by(type_:"group",type_id:@group.id)
      if temp
        ChatroomMember.create(member:current_member,chatroom:temp)
      else
        render json: {
          error: true,
          message: "failed to create group",
          data: "Chatroom create error."
        }.to_json, status: 400
      end
      render json: {
        error: false,
        message: "succeed to create group",
        data: @group
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to create group",
        data: @group.errors
      }.to_json, status: 400
    end
  end

  def destroy
    @chatroom_members = ChatroomMember.find_by(member:current_member,chatroom_id: params[:id])
    if @chatroom_members
      @chatroom_members.destroy
      render json: {
        error: false,
        message: "succeed to exit group",
        data: {}
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to exit group",
        data: "You aren't in this group"
      }.to_json, status: 400
    end
  end

  def invite
    @chatroom_members = ChatroomMember.find_by(member:current_member,chatroom_id: params[:group_id])
    if @chatroom_members
      temp=ChatroomMember.find_by(member_id:params[:id],chatroom_id: params[:group_id])
      if temp
        render json: {
          error: true,
          message: "failed to invite friend into group",
          data: "This member is already in this group."
        }.to_json, status: 400
      else
        @new_chatroom_members=ChatroomMember.new(member_id:params[:id],chatroom_id: params[:group_id])
        if @new_chatroom_members.save
          render json: {
            error: false,
            message: "succeed to invite friend into group",
            data: @new_chatroom_members
          }.to_json, status: 200
        else
          render json: {
            error: true,
            message: "failed to invite friend into group",
            data: "This member isn't exist."
          }.to_json, status: 400
        end
      end
    else
      render json: {
        error: true,
        message: "failed to invite friend into group",
        data: "You aren't in this group"
      }.to_json, status: 400
    end
  end

  def kick_out
    @chatroom_members = ChatroomMember.find_by(member:current_member,chatroom_id: params[:group_id])
    if @chatroom_members
      temp=ChatroomMember.find_by(member_id:params[:id],chatroom_id: params[:group_id])
      if !temp
        render json: {
          error: true,
          message: "failed to kick out somebody from group",
          data: "This member isn't in this group."
        }.to_json, status: 400
      else
      temp.destroy
        render json: {
          error: false,
          message: "succeed to kick out somebody from group",
          data:{}
        }.to_json, status: 200
      end
    else
      render json: {
        error: true,
        message: "failed to kick out somebody from group",
        data: "You aren't in this group"
      }.to_json, status: 400
    end
  end

  def update
    @chatroom_members = ChatroomMember.find_by(member:current_member,chatroom_id: params[:id])
    if @chatroom_members
      temp=Chatroom.find_by(id:@chatroom_members.chatroom_id)
      @group = Group.find_by(id:temp.type_id)
      @group.update(group_params)
      if @group.save
        render json: {
          error: false,
          message: "succeed to update group info",
          data: @group
        }.to_json, status: 200
      else
        render json: {
          error: true,
          message: "failed to update group info",
          data: @group.errors
        }.to_json, status: 400
      end
    else
      render json: {
        error: true,
        message: "failed to update group info",
        data: "You aren't in this group"
      }.to_json, status: 400
    end
  end

  

  private

  def group_params
    params.permit(:name, :photo, :background) 
  end

end
