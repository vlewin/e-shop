class SessionsController < Devise::SessionsController
  skip_before_filter :current_cart

  def destroy
    @current_cart.destroy if @current_cart
    super
  end
end
