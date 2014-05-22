class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def index
    @addresses = Address.all
  end

  def show
  end

  def new
    @address = Address.new
  end

  def edit
    add_breadcrumb 'Home', :root_path
    add_breadcrumb 'Account settings', account_url
    add_breadcrumb 'Edit address', edit_address_url(@address)
  end

  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id

    if @address.save
      flash[:notice] = 'Address was successfully created.'
    else
      flash[:alert] = @address.errors.full_messages.join(', ')
    end

    redirect_to_back_or_default addresses_url
  end

  def update
    if @address.update(address_params)
      flash[:notice] = 'Address was successfully updated.'
    else
      flash[:alert] = @address.errors.full_messages.join(', ')
    end

    redirect_to_back_or_default addresses_url
  end

  def destroy
    if @address.destroy
      flash[:notice] = 'Address was successfully destroyed.'
    else
      flash[:alert] = @address.errors.full_messages.join(', ')
    end
    redirect_to_back_or_default addresses_url
  end

  private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:country, :city, :street, :zip, :phone)
    end
end
