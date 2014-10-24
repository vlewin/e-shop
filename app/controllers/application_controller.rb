class ApplicationController < ActionController::Base
  include FastGettext::Translation
  include Pundit

  protect_from_forgery with: :exception

  before_filter :set_gettext_locale, :authenticate_user!, :current_cart #, :purge_stale_carts
  helper_method :current_view, :current_cart

  rescue_from Exception, with: :handle_exceptions

  # def purge_stale_carts
  #   Cart.where("updated_at  <?", 30.minutes.ago).destroy_all
  # end

  def current_view
    @current_view ||= (params[:view] || session[:view] || 'grid')
    session[:view] = @current_view
    @current_view
  end

  def current_cart
    @current_cart ||= Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @current_cart = Cart.create
    session[:cart_id] = @current_cart.id
    @current_cart
  end

  def redirect_to_back_or_default(default = root_url)
    if request.env['HTTP_REFERER'].present? && request.env['HTTP_REFERER'] != request.env['REQUEST_URI']
      redirect_to :back
    else
      redirect_to default
    end
  end

  private
  def check_product_availability
    redirect_to(root_path, alert: _('This product is out of stock')) if @product.out_of_stock?
  end

  def not_found
    render template: 'application/not_found', status: 404, formats: :html
  end

  def handle_exceptions(exception)
    case exception
    when Pundit::NotAuthorizedError
      flash[:error] = _('You are not authorized to perform this action')
      redirect_to(request.referrer || root_path)
    when Pundit::AuthorizationNotPerformedError
      flash[:error] = _('You are not authorized to perform this action')
    when ActionView::MissingTemplate
      not_found and return
    when ActiveRecord::RecordNotFound
      not_found and return
    when ActionController::UnknownFormat
      not_found and return
    when ActionController::RoutingError
      not_found and return
    else
      logger.error "Exception: #{exception.class}: #{exception.message}"
      logger.error exception.backtrace.join("\n")
    end
  end
end
