class Api::GroupsController < ApplicationController
  before_action :authenticate_member!
  def index
    @group = Group.get_groups(current_member)
    render json: {
      error: false,
      message: "succeed to get groups respect to current member",
      data: @group
    }.to_json
  end

  def show
    @group = Group.find_by(name: params[:name])

    if @group
      render json: {
        error: false,
        message: "succeed to find group",
        data: @group
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to show group",
        data: "group not found"
      }.to_json, status: 404
    end
  end

  def create
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
