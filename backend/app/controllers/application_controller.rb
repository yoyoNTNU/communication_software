class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_id, :photo, :background, :birthday, :introduction,:email ,:password ,:password_confirmation, :name, :phone])
  end

  def authenticate_member!
    unless member_signed_in?
      render :json => {
        error: true,
        message: "Unauthorized",
        data: "The user is not login."
      }.to_json, :status => 401
    end
  end

  def return_not_permit_action
    render :json => {
      error: true,
      message: "Unauthorized",
      data: "User not permitted for this action."
    }.to_json, :status => 401
  end
end
