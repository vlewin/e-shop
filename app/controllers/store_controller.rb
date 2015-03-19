class StoreController < ApplicationController
  respond_to :html, :js

  before_filter :set_filters, only: [:index]
  before_filter :set_product, :check_product_availability, only: [:show]
  before_filter :current_view

  skip_before_filter :current_cart, only: [:index]
  skip_before_filter :authenticate_user!

  def index
    @first_letters = Product.first_letters

    @search = Product.search(@query)
    @products = @search.result.page(@page).per(@limit)
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
    @limit = params[:limit] || Settings.pagination.per_page

    @query = params[:q]
    @sorting = (@query && @query[:s]) ? @query[:s] : ''
  end
end
