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
        incoming: @incoming,
        outgoing: @outgoing
      }
    }.to_json, status: 200
  end

  def create
    friend = Member.find(params[:friend_id])
    @friend_request = current_member.friend_requests.new(friend: friend)

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
    @friend_request.destroy
    render json: {
      message: "succeed to delete request",
      data: {}
    }, status: 200
  end

  def accept
    member.friends << friend
    destroy
  end

  def update
    @friend_request.accept
    head :no_content
  end
  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
