class CartsController < ApplicationController
  respond_to :html, :js
  skip_before_filter :authenticate_user!

  def show
    add_breadcrumb 'Home', :root_path
    add_breadcrumb 'Shopping cart', cart_path(@current_cart)

    if @current_cart.empty?
      flash.notice = "Your cart is empty!"
      redirect_to root_path
    end
  end

  def new
    @cart = Cart.new
  end

  def update
    quantity = params[:quantity].to_i
    line_item = @current_cart.line_items.includes(:product).find(params[:line_item_id])

    if quantity.zero?
      line_item.destroy
    else
      if quantity <= line_item.max_quantity
        line_item.update_attribute(:quantity, params[:quantity])
      else
        puts "*** No more products available #{quantity} => #{line_item.product.available_quantity}"
      end
    end

    # FIXME: update cart line_item count in navbar (XHR request)
    respond_to do |format|
      format.html do
        if @current_cart.empty?
          flash.notice = "Your cart is empty!"
          redirect_to root_path
        else
          redirect_to cart_path
        end
      end

      format.js
    end
  end

  def destroy
    @current_cart.destroy
    redirect_to root_path
  end
end
