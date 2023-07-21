class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def render_create_success
    render json: {
      error: false,
      message: "succeed to sign up",
      data: resource_data
    }.to_json, :status => 200
  end

  def render_create_error
    render json: {
      error: true,
      message: "failed to sign up",
      data: resource_errors
    }.to_json, :status => 401
  end


end