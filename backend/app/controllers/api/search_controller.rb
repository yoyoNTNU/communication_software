class Api::SearchController < ApplicationController
  before_action :authenticate_member!
  
  def by_phone
    @member=Member.find_by(phone:params[:phone])
    if @member
      render json: {
        error: false,
        message: "succeed to search member by phone",
        data: @member
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to search member by phone",
        data: {}
      }.to_json, status: 400
    end
  end

  def by_user_id
    @member=Member.find_by(user_id:params[:user_id])
    if @member
      render json: {
        error: false,
        message: "succeed to search member by user_id",
        data: @member
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to search member by user_id",
        data: {}
      }.to_json, status: 400
    end
  end
end
