class StoreController < ApplicationController
  respond_to :html, :js

  before_filter :set_product, :check_product_availability, only: [:show]
  before_filter :current_view

  skip_before_filter :authenticate_user!

  def index
    # ActiveRecord::Base.logger = nil
    @search = Product.includes(:line_items).search(params[:q])
    @products = @search.result.page(params[:page])
    @categories = Category.all

    redirect_to root_url(locale: params[:set_locale]) if params[:set_locale]
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
