class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError do |exception|
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  before_filter :set_breadcrumb, only: [:index, :show, :edit]

  private
  def set_breadcrumb
    unless controller_name == 'home'
      add_breadcrumb "Home", :root_path, :options => { :title => "Home" }
    end
  #   unless controller_name == 'home'
  #     add_breadcrumb "Home", :root_path, :options => { :title => "Home" }

  #     case params[:action]
  #         when 'index'
  #           add_breadcrumb controller_name.capitalize, "#{controller_name}_path".to_sym
  #         when 'show', 'edit'
  #           if Pundit.policy(current_user, instance).index?
  #             add_breadcrumb controller_name.capitalize, "#{controller_name}_path".to_sym
  #           elsif Pundit.policy(current_user, instance).send("#{params[:action]}?")
  #             add_breadcrumb instance.name
  #           end
  #     end
  #   end
  # end

  # def model
  #   begin
  #     if controller_name == 'registrations'
  #       controller = 'users'
  #       params[:id] = current_user.id
  #     else
  #       controller = params[:controller]
  #     end
  #     controller.singularize.classify.constantize

  #   rescue NameError
  #     nil
  #   end
  # end

  # # TODO: Check for vulnerability
  # def instance
  #   controller_name = controller_name == 'registrations' ? 'users' : params[:controller]
  #   var_name = controller_name.singularize.downcase
  #   instance_variable_set("@#{var_name}", model.find(params[:id]))
  end

  # Devise overrides
  def after_sign_in_path_for(resource)
    current_user.admin? ? categories_path : products_path
  end
end
