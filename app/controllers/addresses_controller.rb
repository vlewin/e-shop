class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy, :delete]
  after_action :verify_authorized, except: [ :new, :create ]

  def index
    authorize :addresses, :index?

    addresses = Address.preload(:user, :billing_orders, :shipping_orders)
    @items = find_and_paginate(addresses, order: 'recipient ASC')

    render(partial: 'addresses', layout: false) and return if request.xhr?
  end

  def show

  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id

    if @address.save
      flash[:notice] = _('Address was successfully created.')

      if current_user.admin?
        redirect_to addresses_path
      else
        redirect_to :back
      end
    else
      if current_user.admin?
        render :new
      else
        redirect_to :back
      end
    end

    # redirect_to_back_or_default addresses_url
  end

  def update
    if @address.update(address_params)
      flash[:notice] = _('Address was successfully updated.')

      if current_user.admin?
        redirect_to addresses_path
      else
        redirect_to :back
      end
    else
      if current_user.admin?
        render :new
      else
        redirect_to :back
      end
    end

    # redirect_to_back_or_default addresses_url
  end

  def delete
    if @address.inactive!
      flash[:notice] = _('Address was successfully destroyed.')
    else
      flash[:alert] = @address.errors.full_messages.join(', ')
    end

    redirect_to account_path
  end

  def destroy
    if @address.destroy
      flash[:notice] = _('Address was successfully destroyed.')
    else
      flash[:alert] = @address.errors.full_messages.join(', ')
    end

    redirect_to_back_or_default addresses_url
  end

  private
    def set_address
      @address = if current_user.admin?
        Address.find(params[:id])
      else
        current_user.addresses.active.find(params[:id])
      end

       authorize @address
    end

    def address_params
      params.require(:address).permit(:recipient, :city, :street, :zip_code, :phone)
    end
end
