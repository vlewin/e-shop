class StoreController < ApplicationController
  respond_to :html, :js

  before_filter :set_filters, only: [:index]
  before_filter :set_product, :check_product_availability, only: [:show]
  before_filter :current_view

  skip_before_filter :current_cart, only: [:index]
  skip_before_filter :authenticate_user!

  def index
    @search = Product.search(@query)
    @products = @search.result.page(@page).per(@limit)

    # FIXME: Use database
    @init_letters = @products.map{|p| p.title.first if p.title}.uniq.sort
    @categories ||= Category.all.order(:title)
  end

  def show
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def set_filters
    @page = params[:page]
    @limit = params[:limit] || 4

    @query = params[:q]
    @sorting = (@query && @query[:s]) ? @query[:s] : ''
  end
end
