class LineItemsController < ApplicationController
  before_filter :set_product, :check_product_availability, only: [:create]
  skip_before_filter :authenticate_user!

  def new
    @line_item = LineItem.new()
  end

  def create
    linet_item = @current_cart.add_item(params[:product_id], params[:quantity])
    flash[:notice] = _("%s x %s added to your cart!") % [params[:quantity], linet_item.product.title] if linet_item
    redirect_to_back_or_default root_path
  end

  def update
    line_item = @current_cart.update_item(params[:id], params[:quantity])
    redirect_to cart_path
  end

  def destroy
    line_item = @current_cart.line_items.find(params[:id])
    line_item.destroy

    if current_cart.empty?
      redirect_to root_path, notice: _('Your cart is empty!')
    else
      redirect_to_back_or_default root_path
    end
  end

  private
  def set_product
    @product = Product.find(params[:product_id])
  end
end
