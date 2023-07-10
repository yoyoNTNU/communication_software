class ApplicationController < ActionController::Base
        include DeviseTokenAuth::Concerns::SetUserByToken
        skip_before_action :verify_authenticity_token
        before_action :configure_permitted_parameters, if: :devise_controller?

        protected

        def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:user_id, :photo, :background, :birthday, :introduction,:email ,:password, :name, :phone])
        end
end
