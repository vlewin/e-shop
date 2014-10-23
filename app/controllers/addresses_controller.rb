class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def index
    @addresses = Address.preload(:user).all
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
    else
      flash[:alert] = @address.errors.full_messages.join(', ')
    end

    redirect_to_back_or_default addresses_url
  end

  def update
    if @address.update(address_params)
      flash[:notice] = _('Address was successfully updated.')
    else
      flash[:alert] = @address.errors.full_messages.join(', ')
    end

    redirect_to_back_or_default addresses_url
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
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:recipient, :city, :street, :zip_code, :phone)
    end
end
