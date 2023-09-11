class Auth::PasswordsController < DeviseTokenAuth::PasswordsController
  # this is where users arrive after visiting the password reset confirmation link
  def edit
    # if a user is not found, return nil
    @resource = resource_class.with_reset_password_token(resource_params[:reset_password_token])

    if @resource && @resource.reset_password_period_valid?
      token = @resource.create_token unless require_client_password_reset_token?

      # ensure that user is confirmed
      @resource.skip_confirmation! if confirmable_enabled? && !@resource.confirmed_at
      # allow user to change password once without current_password
      @resource.allow_password_change = true if recoverable_enabled?

      @resource.save!

      yield @resource if block_given?

      if require_client_password_reset_token?
        redirect_to DeviseTokenAuth::Url.generate(@redirect_url, reset_password_token: resource_params[:reset_password_token])
      else
        if DeviseTokenAuth.cookie_enabled
          set_token_in_cookie(@resource, token)
        end
        redirect_header_options = { reset_password: true }
        redirect_headers = build_redirect_headers(token.token,token.client,redirect_header_options)
        redirect_to(@resource.build_auth_url(@redirect_url,redirect_headers), allow_other_host: true)
      end
    else
      render_edit_error
    end
  end


  def reset
    
  end
    protected

    def render_create_error_missing_email
      render json: {
          error: true,
          message: "failed to sent reset password email",
          data: I18n.t('devise_token_auth.passwords.missing_email')
      }.to_json, :status => 400
    end

    def render_create_error_missing_redirect_url
      render json: {
          error: true,
          message: "failed to sent reset password email",
          data: I18n.t('devise_token_auth.passwords.missing_redirect_url')
      }.to_json, :status => 400
    end

    def render_not_found_error
      if Devise.paranoid
        render_create_success
      else
        render json: {
          error: true,
          message: "failed to sent reset password email",
          data: "Unable to find user with email '#{@email}'."
      }.to_json, :status => 400
      end
    end

    def render_create_success
      render json: {
          error: false,
          message: "succeed to sent reset password email",
          data: success_message('passwords', @email)
      }.to_json, :status => 200
    end

    def render_update_error_unauthorized
      render json: {
        error: true,
        message: "Unauthorized",
        data: "The user is not login."
      }.to_json, :status => 401
    end

    def render_update_error_missing_password
      render json: {
          error: true,
          message: "failed to update password",
          data: I18n.t('devise_token_auth.passwords.missing_passwords')
      }.to_json, :status => 400
    end

    def render_update_success
      render json: {
          error: false,
          message: "succeed to update password",
          data: I18n.t('devise_token_auth.passwords.successfully_updated')
      }.to_json, :status => 200
    end

    def render_update_error
      render json: {
          error: true,
          message: "failed to update password",
          data: resource_errors
      }.to_json, :status => 400
    end
    

  private
    def resource_params
      params.permit(:email, :password, :password_confirmation,:redirect_url)
    end
end
