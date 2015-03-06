class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update_status, :destroy]
  after_action :verify_authorized, only: [:show, :destroy]
  after_action :verify_policy_scoped, only: :index

  def index
    orders = policy_scope(Order).includes(:shipment, :payment, :line_items)
    @items = find_and_paginate(orders, order: 'updated_at DESC')

    authorize :orders, :index?
  end

  def show
    authorize @order

    respond_to do |format|
      format.html
      format.js
      format.pdf do
        send_data OrderPdf.new(@order, view_context).render, filename: "order_#{@order.id}", type: "application/pdf", disposition: "inline"
      end
    end

  end

  def new
    @cart = current_cart
    @shipments = Shipment.all
    @address = Address.new

    if @cart.line_items.empty?
      redirect_to root_path, notice: _('Your cart is empty!') and return
    else
      @order = Order.new
    end
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.add_line_items_from_cart(@current_cart)

    respond_to do |format|
      if @order.valid? && @order.save
        @current_cart.destroy
        session[:cart_id] = nil

        # FIXME: Send notification email
        UserMailer.order_confirmation(current_user, @order).deliver_now

        format.html { redirect_to root_path, notice: _('Thank you for your order!') }
      else
        format.html { render action: 'new' }
      end
    end
  end


  def update_status
    prev_status = @order.status

    if @order.update(order_params)
      notice = "Order status changed from '%s' to '%s'" % [prev_status.humanize, order_params[:status].humanize]
      redirect_to orders_path, notice: notice
    else
      redirect_to orders_path, error: _('Can not change order status')
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
    params.require(:order).permit(:shipping_address_id, :billing_address_id, :shipment_id, :payment_id, :status)
  end

end
