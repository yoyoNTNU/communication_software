class Api::GroupsController < ApplicationController
  before_action :authenticate_member! ,except: :show
  def index
    @chatroom=ChatroomMember.where(member:current_member)
    @group=[]
    @chatroom.each do |c|
      temp=Chatroom.find_by(id:c.chatroom_id,type_:"group")
      @group<<temp
    end
    render json: {
      error: false,
      message: "succeed to get groups respect to current member",
      data: @group
    }.to_json
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
    params.permit(:name, :photo, :background) # 根據您的 Group 模型欄位來設定 strong parameters
  end

end
