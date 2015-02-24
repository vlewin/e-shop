class LineItemsController < ApplicationController
  before_filter :set_product, :check_product_availability, only: [:create]
  skip_before_filter :authenticate_user!

  def new
    @line_item = LineItem.new()
  end

  def create
    @cart = current_cart
    @line_item = @cart.add_product(params[:product_id], params[:quantity])

    if @line_item.save!
      redirect_to root_path, notice: _("%s x %s added to your cart!") % [params[:quantity], @line_item.product.title]
    else
      render action: 'new'
    end
  end

  def destroy
    @line_item = @current_cart.line_items.find(params[:id])
    @line_item.destroy

    if current_cart.empty?
      redirect_to root_path
    else
      redirect_to_back_or_default root_path
    end
  end

  private
  def set_product
    @product = Product.find(params[:product_id])
  end
end
