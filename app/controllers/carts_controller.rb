class CartsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: [:show, :update, :destroy]

  def index
    authorize :carts, :index?

    @items = find_and_paginate(order: 'updated_at DESC')
    render(partial: 'carts', layout: false) and return if request.xhr?
  end

  def show
    redirect_to root_path, notice: _('Your cart is empty!') if current_cart.empty?
  end

  def update_shipment
    current_cart.update(shipment_id: params[:shipment_id])
    render(partial: 'orders/summary', layout: false) and return if request.xhr?
  end

  def purge
    authorize :carts, :purge?

    Cart.purge
    redirect_to carts_path
  end

  def destroy
    cart = (current_user && current_user.admin?) ? Cart.find(params[:id]) : current_cart

    if cart.destroy
      flash.notice = _('Cart was successfully destroyed.')
    else
      flash.error = _('Something went wrong')
    end

    redirect_to_back_or_default root_path

  end
end
