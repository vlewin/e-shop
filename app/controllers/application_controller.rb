class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError do |exception|
    flash[:error] = t('authorization.not_authorized')
    redirect_to(request.referrer || root_path)
  end

  before_filter :authenticate_user!
  before_filter :set_locale

  before_filter :current_cart

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
    if request.env['HTTP_REFERER'].present? && request.env['HTTP_REFERER'] != request.env['REQUEST_URI']
      redirect_to :back
    else
      redirect_to default
    end
  end

  # Devise overrides
  def after_sign_in_path_for(resource)
    if request.referrer.include? 'orders/new'
      request.referrer
    else
      root_path
    end
  end

  private
  def check_product_availability
    redirect_to(root_path, alert: 'This product is out of stock') if @product.out_of_stock?
  end
end
