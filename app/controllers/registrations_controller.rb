class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?

  def edit
    add_breadcrumb current_user.name
    super
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password)}
  end

  # Redirect back to user profile
  def after_update_path_for(resource)
    case resource
    when :user, User
      user_path(current_user)
    else
      super
    end
  end
end
