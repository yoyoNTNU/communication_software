class Auth::TokenValidationsController < DeviseTokenAuth::TokenValidationsController
  def render_validate_token_success
    render json: {
        error: false,
        message: "succeed to validate",
        data:  resource_data(resource_json: @resource.token_validation_response)
    }.to_json, :status => 200
  end

  def render_validate_token_error
    render json: {
        error: true,
        message: "failed to validate",
        data: I18n.t('devise_token_auth.token_validations.invalid')
    }.to_json, :status => 401
end

end