class ProductsController < ApplicationController
  respond_to :html, :js

  before_filter :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show]

  def index
    authorize :products, :index?

    @items = find_and_paginate(Product.includes(:vat), order: 'product_translations.title ASC')
    render(partial: 'products', layout: false) and return if request.xhr?
  end

  def show
    authorize @product
  end

  def new
    redirect_to products_url, alert: _('Please create a category first.') unless Category.exists?

    @product = Product.new
    @next_id = Product.next_id
    authorize @product
  end

  def edit
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product

    if @product.save
      redirect_to products_url, notice: _('Product was successfully created.')
    else
      render action: 'new'
    end
  end

  def update
    authorize @product

    if @product.update(product_params)
      redirect_to products_url, notice: _('Product was successfully updated.')
    else
      render action: 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    authorize @product

    if @product.destroy
      redirect_to products_url, notice: _('Product was successfully destroyed.')
    else
      redirect_to products_url, alert: "#{@product.errors.full_messages.join(', ')}"
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def product_params
    params.require(:product).permit(
      :ean,
      :title,
      :description,
      :quantity,
      :price,
      :vat_id,
      :category_id,
      :image,
      *Product.globalize_attribute_names
    )
  end

end
