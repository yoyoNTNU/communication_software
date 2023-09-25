class Api::MemberController < ApplicationController
  before_action :authenticate_member! , except: :other
  def update
    @member=current_member
    if @member.update(info_params)
      render json: {
        error: false,
        message: "succeed to update member info",
        data: @member
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to update member info",
        data: @member.errors
      }.to_json, status: 400
    end
  end

  def destroy_photo
    @member=current_member
    if !@member.photo.url.nil?
      @member.remove_photo! 
      @member.save
    end
    render json: {
      error: false,
      message: "succeed to update member info",
      data: @member
    }.to_json, status: 200
  end

  def destroy_background
    @member=current_member
    if !@member.background.url.nil?
      @member.remove_background! 
      @member.save
    end
    render json: {
      error: false,
      message: "succeed to update member info",
      data: @member
    }.to_json, status: 200
  end

  def show
    @member=current_member
    render json: {
      error: false,
      message: "succeed to get member info",
      data: @member
    }.to_json, status: 200
  end

  def other
    @member=Member.find_by(id:params[:id])
    if @member
      render json: {
        error: false,
        message: "succeed to get member info",
        data: @member
      }.to_json, status: 200
    else
      render json: {
        error: true,
        message: "failed to get member info",
        data: "Member isn't exist."
      }.to_json, status: 400
    end
  end

  def feedback
    member=current_member
    type_=feedback_params[:type_]
    content=feedback_params[:content]
    if (type_.blank?||content.blank?)
      render json: {
        error: true,
        message: "failed to sent feedback",
        data: "Lost some information."
      }.to_json, status: 400
    else
      time=Time.now
      MemberMailer.sent_feedback_email(member,type_,content,time).deliver_now
      render json: {
        error: false,
        message: "succeed to sent feedback",
        data: {}
      }.to_json, status: 200
    end
  end

  private

  def info_params
    #user_id,email,phone can't be modify.
    #password should though devise to modify.
    params.permit(:photo, :background, :birthday, :introduction, :name, :is_login_mail)
  end

  def feedback_params
    params.permit(:type_,:content)
  end
end
