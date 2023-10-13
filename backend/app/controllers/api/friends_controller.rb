class Api::FriendsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_friend, except:[:index,:check]

  def index
    @friends = Friendship.where(member:current_member)
    render json: {
      error: false,
      message: "succeed to get friend list",
      data: @friends
    }.to_json, status: 200
  end

  def show
    if @friendship
      friend=@friend
      friend.name=@friendship.nickname
      render json: {
        error: false,
        message: "succeed to get friend info",
        data: friend
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to get friend info",
        data: "you are not friends."
      }.to_json, status: 400
    end
  end

  def check
    @friend=Member.find_by(id:params[:friend_id])
    if !@friend
      render json: {
        error: true,
        message: "failed to get member",
        data: {}
      }.to_json, status: 400
    elsif @friend==current_member
      render json: {
        error: false,
        message: "succeed to get relationship",
        data: {
          relationship: "Yourself",
          info: "#{@friend.name} is yourself."
        }
      }.to_json, status: 200
    else 
      @friendship=Friendship.find_by(member:current_member,friend:@friend)
      if @friendship
        render json: {
          error: false,
          message: "succeed to get relationship",
          data: {
            relationship: "Friend",
            info:"#{current_member.name} and #{@friend.name} is friends."
          }
        }.to_json, status: 200
      else
        if FriendRequest.find_by(friend:@friend,member:current_member)
          render json: {
            error: false,
            message: "succeed to get relationship",
            data: {
              relationship: "Sender",
              info:"#{current_member.name} has send request to #{@friend.name}."
            }
          }.to_json, status: 200
        elsif  FriendRequest.find_by(friend:current_member,member:@friend)
          render json: {
            error: false,
            message: "succeed to get relationship",
            data: {
              relationship: "Receiver",
              info:"#{current_member.name} has received request from #{@friend.name}."
            }
          }.to_json, status: 200
        else
          render json: {
            error: false,
            message: "succeed to get relationship",
            data: {
              relationship: "None",
              info:"#{current_member.name} and #{@friend.name} have no relationship."
            }
          }.to_json, status: 200
        end
      end
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
    @friend=Member.find_by(id:params[:id])
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
        message: "failed to set friendship",
        data: "This is yourself."
      }.to_json, status: 200
      return
    else 
      @friendship=Friendship.find_by(member:current_member,friend:@friend)
    end
  end

  def friend_params
    params.permit(:nickname)
  end
end
