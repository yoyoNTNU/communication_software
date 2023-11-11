class Api::FriendRequestsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_friend_request, except: [:index, :create]
  
  def index
    @incoming = FriendRequest.where(friend: current_member)
    @outgoing = current_member.friend_requests
    render json: {
      error: false,
      message: "succeed to get all sent and received requests",
      data: {
        received: @incoming,
        send: @outgoing
      }
    }.to_json, status: 200
  end

  def create
    @friend_request = current_member.friend_requests.new(request_params)
    if @friend_request.save
      render json: {
        error: false,
        message: "succeed to sent request",
        data: @friend_request
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to sent request",
        data: @friend_request.errors
      }.to_json, status: 400
    end
  end

  def destroy
    if @friend_request.member!=current_member
      return_not_permit_action
    else
      @friend_request.destroy
      render json: {
        error: false,
        message: "succeed to delete request",
        data: {}
      }.to_json, status: 200
    end
  end

  def accept
    if @friend_request.friend!=current_member
      return_not_permit_action
    else
      @friend=Friendship.create!(member:@friend_request.member,friend:@friend_request.friend)
      @friend_request.destroy
      render json: {
        error: false,
        message: "succeed to accept request",
        data: "#{@friend.member.name} and #{@friend.friend.name} become friends."
      }.to_json, status: 200
    end
  end

  def reject
    if @friend_request.friend!=current_member
      return_not_permit_action
    else
      @friend_request.destroy
      render json: {
        error: false,
        message: "succeed to reject request",
        data: {}
      }.to_json, status: 200
    end
  end
  
  private

  def set_friend_request
    @friend_request = FriendRequest.find_by(member: current_member, friend_id: params[:friend_id])
    if !@friend_request
      @friend_request2 = FriendRequest.find_by(member_id: params[:friend_id], friend: current_member)
      if !@friend_request2
        render json: {
          error: true,
          message: "failed to get specific request",
          data: {}
        }.to_json, status: 400
        return
      else
        @friend_request = @friend_request2
      end
    end
  end

  def request_params
    params.permit(:friend_id, :content)
  end
end
