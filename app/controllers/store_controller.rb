class StoreController < ApplicationController
  respond_to :html, :js
  before_filter :set_product, :check_product_availability, only: [:show]
  skip_before_filter :authenticate_user!

  def index
    puts "*** Index"
    @search = Product.includes(:line_items).search(params[:q])
    @products = @search.result.page(params[:page])
    @categories = Category.all
    @view = params[:view] || 'grid'

    redirect_to root_url(locale: params[:set_locale]) if params[:set_locale]

    # respond_to do |format|
    #   format.html { redirect_to root_url(locale: params[:set_locale]) if params[:set_locale] }
    #   # format.js do
    #   #   render partial: "products_#{params[:view] || 'grid'}"
    #   # end
    # end

  end

  def show
    add_breadcrumb 'Home', :root_path
    add_breadcrumb @product.name, store_product_url(@product)
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end
end
