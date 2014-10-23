class CartsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show, :update]
  after_action :verify_authorized, except: [:show, :update]

  def index
    @carts = Cart.all.order(:updated_at)
    authorize @carts
  end

  def show
    add_breadcrumb _('Store'), :root_path
    add_breadcrumb _('Shopping cart'), cart_path(@current_cart)

    if @current_cart.empty?
      flash.notice = _('Your cart is empty!')
      redirect_to root_path
    end
  end

  def update
    quantity = params[:quantity].to_i
    line_item = @current_cart.line_items.includes(:product).find(params[:line_item_id])

    if quantity.zero?
      line_item.destroy
    else
      if quantity <= line_item.max_quantity
        line_item.update_attribute(:quantity, params[:quantity])
      end
    end

    if @current_cart.empty?
      flash.notice = _('Your cart is empty!')
      redirect_to root_path
    else
      redirect_to cart_path
    end
  end

  def destroy
    @cart = (current_user.admin?) ? Cart.find(params[:id]) : @current_cart

    if @cart.destroy
      flash.notice = _('Cart was successfully destroyed.')
    else
      flash.error = _('Something went wrong')
    end

    redirect_to_back_or_default root_path

  end
end
