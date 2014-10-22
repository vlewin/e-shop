class AccountController < Devise::RegistrationsController
  before_filter :authenticate_user!, only: [:show]
  before_filter :update_sanitized_params, if: :devise_controller?

  after_action :verify_authorized, only: [:show]

  def authenticate_user!
    redirect_to new_user_session_path, alert: t('devise.failure.unauthenticated') if current_user.nil?
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ? :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
    else
      clean_up_passwords resource
    end

    render template: "account/show"
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

  def show
    add_breadcrumb "Home", :root_path
    add_breadcrumb 'Account settings', account_url

    @user = current_user
    authorize @user
  end

  private
  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password)}
  end
end
