class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError do |exception|
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  # Redirect to products or dashboard
  # FIXME: Redirect admin user to dashboard
  def after_sign_in_path_for(resource)
    current_user.admin? ? categories_path : products_path
  end
end
