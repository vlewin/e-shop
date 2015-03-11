class StoreController < ApplicationController
  respond_to :html, :js

  before_filter :set_product, :check_product_availability, only: [:show]
  before_filter :current_view

  skip_before_filter :current_cart, only: [:index]
  skip_before_filter :authenticate_user!

  def index
    query = params[:q]

    @limit = params[:limit] || Settings.pagination.per_page
    @search = Product.includes(:line_items).search(query)
    @sorting = (query && query[:s]) ? query[:s] : ''
    @products = @search.result.page(params[:page]).per(@limit)

    @init_letters = @products.map{|p| p.title.first if p.title}.uniq.sort
    @categories ||= Category.all.order(:title)
  end

  def show
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end
end
