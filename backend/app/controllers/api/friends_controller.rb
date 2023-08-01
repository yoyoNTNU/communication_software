class Api::FriendsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_friend, except:[:index]

  def index
    @friends = Friendship.where(member:current_member)
    render json: {
      error: false,
      message: "succeed to get friend list",
      data: @friends
    }.to_json, status: 200
  end

  def check
    if @friendship
      render json: {
        error: false,
        message: "succeed to get relationship",
        data: "#{current_member.name} and #{@friend.name} is friends."
      }.to_json, status: 200
    else
      render json: {
        error: false,
        message: "succeed to get relationship",
        data: "#{current_member.name} and #{@friend.name} is not friends."
      }.to_json, status: 200
    end
  end

  def destroy
    if @friendship
      @friendship.destroy
      render json: {
        error: false,
        message: "succeed to delete friend",
        data: {}
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to delete friend",
        data: "you are not friends."
      }.to_json, status: 400
    end
  end

  def update
    if @friendship
      if @friendship.update(friend_params)
        render json: {
          error: false,
          message: "succeed to update friend info",
          data: @friendship
        }.to_json, status: 200
      else
        render json: {
          error: true,
          message: "failed to update friend info",
          data: @friendship.errors
        }.to_json, status: 400
      end
    else
      render json: {
        error: true,
        message: "failed to update friend info",
        data: "you are not friends."
      }.to_json, status: 400
    end
  end

  private

  def set_friend
    @friend=Member.find_by(id:params[:friend_id])
    if !@friend
      render json: {
        error: true,
        message: "failed to get member",
        data: {}
      }.to_json, status: 400
      return
    elsif @friend==current_member
      render json: {
        error: true,
        message: "failed to get relationship",
        data: "This is yourself."
      }.to_json, status: 400
      return
    else 
      @friendship=Friendship.find_by(member:current_member,friend:@friend)
    end
  end

  def friend_params
    params.permit(:background, :nickname)
  end
end
