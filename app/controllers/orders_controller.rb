class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = policy_scope(Order)
    # FIXME: add permission check test!
    authorize @orders
  end

  def show
    # FIXME: add permission check test!
    authorize @order

    add_breadcrumb 'Home', :root_path
    add_breadcrumb 'Account settings', account_url
    add_breadcrumb "Order ##{@order.id}", order_url(@order)

    @billing_address = @order.billing_address || @order.address

    respond_to do |format|
      format.html
      format.js
      format.pdf do
        send_data OrderPdf.new(@order, view_context).render, filename: "order_#{@order.id}", type: "application/pdf", disposition: "inline"
      end
    end

  end

  def new
    add_breadcrumb 'Home', :root_path
    add_breadcrumb 'Checkout', new_order_path

    @cart = current_cart
    @shipments = Shipment.all
    @address = Address.new

    if @cart.line_items.empty?
      redirect_to root_path, notice: "Your cart is empty"
      return
    else
      @order = Order.new
    end
  end

  # def edit
  # end

  def create
    @order = Order.new(order_params)
    @order.shipment = Shipment.find(order_params[:shipment_id])
    @order.add_line_items_from_cart(@current_cart)
    @order.user = current_user

    respond_to do |format|
      if @order.valid? && @order.save
        @current_cart.destroy
        session[:cart_id] = nil

        # FIXME: Send notification email
        # OrderNotifier.received(@order).deliver

        format.html { redirect_to root_path, notice: I18n.t('.thanks') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # def update
  #   respond_to do |format|
  #     if @order.update(order_params)
  #       format.html { redirect_to @order, notice: 'Order was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @order.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # FIXME: Move admin actions to the separate controller!
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    def set_order
      @order = policy_scope(Order).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:shipping_address_id, :billing_address_id, :shipment_id, :pay_type)
    end

end
