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
  end

  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id

    if @address.save
      if current_user.admin?
        redirect_to @address, notice: 'Address was successfully created.'
      else
        redirect_to user_path(current_user), notice: 'Address was successfully created.'
      end
    else
      render action: 'new'
    end
  end

  def update
    if @address.update(address_params)
      if current_user.admin?
        redirect_to @address, notice: 'Address was successfully updated.'
      else
        redirect_to user_path(current_user), notice: 'Address was successfully updated.'
      end
    else
      render action: 'edit'
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_url, notice: 'Address was successfully destroyed.'
  end

  private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:country, :city, :street, :zip, :phone)
    end
end
