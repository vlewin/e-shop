class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError do |exception|
    flash[:error] = t('authorization.not_authorized')
    redirect_to(request.referrer || root_path)
  end

  before_action :authenticate_user!
  before_action :set_locale

  # before_filter :set_breadcrumb #, only: [:index, :show, :edit]
  before_filter :current_cart

  # private

  def current_cart
    @current_cart ||= Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @current_cart = Cart.create
    session[:cart_id] = @current_cart.id
    @current_cart
  end

  # Locale
  def set_locale
    I18n.locale = params[:locale] unless params[:locale].blank?
  end

  # Extract the language from the clients browser
  def extract_locale_from_accept_language_header
    browser_locale = request.env['HTTP_ACCEPT_LANGUAGE'].try(:scan, /^[a-z]{2}/).try(:first).try(:to_sym)
    if I18n.available_locales.include? browser_locale
      browser_locale
    else
      I18n.default_locale
    end
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  def redirect_to_back_or_default(default = root_url)
    if request.env['HTTP_REFERER'].present? and request.env['HTTP_REFERER'] != request.env['REQUEST_URI']
      redirect_to :back
    else
      redirect_to default
    end
  end

  # def set_breadcrumb
    # unless controller_name == 'home'
      # add_breadcrumb 'Home', :root_path, options: { title: 'Home' }
    # end

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
  # end

  # Devise overrides
  def after_sign_in_path_for(resource)
    current_user.admin? ? categories_path : products_path
  end
end
