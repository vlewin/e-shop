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
    @shipment = Shipment.new(shipments_params)

    if @shipment.save
      redirect_to @shipment, notice: 'Shipment was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @shipment.update(shipments_params)
      redirect_to @shipments, notice: 'Shipment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @shipments.destroy
    redirect_to shipmentss_url, notice: 'Shipment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipments
      @shipment = Shipment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shipments_params
      params.require(:shipments).permit(:provider, :name, :rate)
    end
end
