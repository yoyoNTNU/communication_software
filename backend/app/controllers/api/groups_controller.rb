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

  def create
    #只有創建群組的人要在建立群組時建立CM，其他人等邀請的時候寫在controller
    @group = Group.new(group_params)

    if @group.save
      render json: {
        error: false,
        message: "succeed to create group",
        data: @group
      }.to_json, status: 200
    end
  end

  def update
    if @group.update(group_params)
      render json: {
        error: false,
        message: "succeed to create group",
        data: @group
      }.to_json, status: 200
    end
  end

  def destroy
    @group = GroupMember.where(member_id: current_member).find(params[:id])
    if  @group 
      @group.destroy
      render json: {
        error: false,
        message: "succeed to withdraw from group",
        data: @group
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to withdraw from group",
        data: "You aren't in this group"
      }.to_json, status: 400
    end
  end

  private

  def group_params
    params.permit(:name, :photo, :background) 
  end

end
