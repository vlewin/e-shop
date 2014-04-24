class CartsController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    @carts = Cart.all
  end

  def show
    if @current_cart.empty?
      flash.notice = "Your cart is empty!"
      redirect_to_back_or_default
    end
  end

  def new
    @cart = Cart.new
  end

  def destroy
    @current_cart.destroy
    redirect_to(root_url)
  end
end
