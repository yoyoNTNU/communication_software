class Api::MemberController < ApplicationController
  before_action :authenticate_member!
  def update
    @member=current_member
    if @member.update(info_params)
      render json: {
        error: false,
        message: "succeed to update member info",
        data: @member
      }.to_json, status: 200
    else
      render :json => {
        error: true,
        message: "failed to update member info",
        data: @member.errors
      }.to_json, :status => 400
    end
  end

  def show
    @member=current_member
    render json: {
      error: false,
      message: "succeed to get member info",
      data: @member
    }.to_json, status: 200
  end
  private

  def info_params
    #user_id,email,phone can't be modify.
    #password should though devise to modify.
    params.permit(:photo, :background, :birthday, :introduction, :name, :is_login_mail)
  end
end
