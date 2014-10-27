class StoreController < ApplicationController
  respond_to :html, :js

  before_filter :set_product, :check_product_availability, only: [:show]
  before_filter :current_view

  skip_before_filter :current_cart, only: [:index]
  skip_before_filter :authenticate_user!

  def index
    # ActiveRecord::Base.logger = nil
    @search = Product.includes(:line_items).search(params[:q])
    @sorting = (params[:q] && params[:q][:s]) ? params[:q][:s] : ''
    @products = @search.result.page(params[:page])
    @init_letters = Product.select(:title).map{ |product| product.title.first }.uniq.sort
    @categories ||= Category.all.order(:title)
  end

  def show
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end
end
