class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    add_breadcrumb 'Order'
  end

  def new
    add_breadcrumb 'Order'

    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to products_url, notice: "Your cart is empty"
      return
    else
      @order = Order.new
    end
  end

  def edit
  end

  def create
    puts "**** Create order"
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        # FIXME: Send notification email
        # OrderNotifier.received(@order).deliver

        format.html { redirect_to products_url, notice: I18n.t('.thanks') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
  #...
end
