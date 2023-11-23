class ApplicationController < ActionController::Base
    add_flash_types :success, :danger, :warning, :info
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def check_if_admin
        redirect_to root_path unless current_user.admin?
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:dni, :first_name, :last_name, :address])
        devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :address])
    end
end
