class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  def index
    authorize :payments, :index?

    @items = find_and_paginate(order: 'payment_translations.title ASC')
    render(partial: 'payments', layout: false) and return if request.xhr?
  end

  def show
    authorize @payment
  end

  def new
    @payment = Payment.new
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      redirect_to payments_path, notice: _('Payment was successfully created.')
    else
      render action: 'new'
    end
  end

  def update
    if @payment.update(payment_params)
      redirect_to payments_path, notice: _('Payment was successfully updated.')
    else
      render action: 'edit'
    end
  end

  def destroy
    @payment.destroy
    redirect_to payments_path, notice: _('Payment was successfully destroyed.')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def payment_params
      params.require(:payment).permit(:title, *Payment.globalize_attribute_names)
    end
end
