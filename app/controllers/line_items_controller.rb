class LineItemsController < ApplicationController
  skip_before_filter :authenticate_user!

  def new
    @line_item = LineItem.new()
  end

  def create
    @cart = current_cart
    @line_item = @cart.add_product(params[:product_id], params[:quantity])

    if @line_item.save!
      redirect_to(root_path, notice: "#{params[:quantity]} x #{@line_item.product.name} added to your cart!")
    else
      render action: 'new'
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    redirect_to_back_or_default line_items_url
  end
end
