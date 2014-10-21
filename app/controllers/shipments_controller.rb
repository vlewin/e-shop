class ShipmentsController < ApplicationController
  before_action :set_shipments, only: [:show, :edit, :update, :destroy]

  def index
    @shipments = Shipment.all
  end

  def show
  end

  def new
    @shipment = Shipment.new
  end

  def edit
  end

  def create
    @shipment = Shipment.new(shipment_params)

    if @shipment.save
      redirect_to shipments_path, notice: 'Shipment was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @shipment.update(shipment_params)
      redirect_to shipments_path, notice: 'Shipment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @shipment.destroy
    redirect_to shipments_path, notice: 'Shipment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipments
      @shipment = Shipment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shipment_params
      params.require(:shipment).permit(:provider, :name, :rate, :default)
    end
end
