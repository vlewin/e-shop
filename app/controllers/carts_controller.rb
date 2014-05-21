class CartsController < ApplicationController
  respond_to :html, :js
  skip_before_filter :authenticate_user!

  def show
    if @current_cart.empty?
      flash.notice = "Your cart is empty!"
      redirect_to_back_or_default  # unless request.xhr?
    end
  end

  def new
    @cart = Cart.new
  end

  def update
    line_item = @current_cart.line_items.find(params[:line_item_id])
    if params[:quantity].to_i.zero?
      line_item.destroy
    else
      line_item.update_attribute(:quantity, params[:quantity])
    end

    # FIXME: update cart line_item count in navbar (XHR request)
    respond_to do |format|
      format.html do
        if @current_cart.empty?
          flash.notice = "Your cart is empty!"
          redirect_to root_path
        else
          redirect_to @current_cart
        end
      end

      format.js
    end
  end

  def destroy
    @current_cart.destroy
    redirect_to(root_url)
  end
end
