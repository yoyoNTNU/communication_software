class Api::FriendsController < ApplicationController
  before_action :set_friend, only: :destroy

  def index
    @friends = current_member.friends
  end

  def destroy
    current_member.remove_friend(@friend)
  end

  private

  def set_friend
    @friend = current_member.friends.find(params[:id])
  end
end
