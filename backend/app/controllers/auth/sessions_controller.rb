class Auth::SessionsController < DeviseTokenAuth::SessionsController

  def render_create_success
    MemberMailer.login_success_email(@resource).deliver_now
    render json: {
        error: false,
        message: "succeed to sign in",
        data: resource_data(resource_json: @resource.token_validation_response)
    }.to_json, :status => 200
  end

  def render_create_error_not_confirmed
    MemberMailer.login_failed_email(@resource).deliver_now
    render json: {
        error: true,
        message: "failed to sign in",
        data: I18n.t('devise_token_auth.sessions.not_confirmed', email: @resource.email)
    }.to_json, :status => 401
  end

  def render_create_error_bad_credentials
    MemberMailer.login_failed_email(@resource).deliver_now
    render json: {
        error: true,
        message: "failed to sign in",
        data: I18n.t('devise_token_auth.sessions.bad_credentials')
    }.to_json, :status => 401
  end

  def render_destroy_success
    render json: {
        error: false,
        message: "succeed to sign out",
        data: {}
    }.to_json, :status => 200
  end

  def render_destroy_error
    render json: {
        error: true,
        message: "failed to sign out",
        data: I18n.t('devise_token_auth.sessions.user_not_found')
    }.to_json, :status => 404
  end

end