class StoreController < ApplicationController
  respond_to :html, :js

  before_filter :set_product, :check_product_availability, only: [:show]
  before_filter :current_view

  skip_before_filter :current_cart, only: [:index]
  skip_before_filter :authenticate_user!

  def index
    # ActiveRecord::Base.logger = nil

    # FIXME: ILIKE case insensitive search (use LOWER() in ransacker and check POSTGRESQL)
    query = params[:q]

    # INFO: issue with cyrillic characters 'слово'.capitalize => 'слово'
    # Try it out instead of Unicode::capitalize
    # begin
    #   str.encode("UTF-8")
    # rescue Encoding::UndefinedConversionError
    #  # ...
    # end
    # query = Hash[params[:q].map{|k,v| [k,Unicode::capitalize(v)]}] if (params[:q] && params[:q][:translations_title_cont])

    @limit = params[:limit] || 12
    @search = Product.includes(:line_items).search(query)
    @sorting = (params[:q] && params[:q][:s]) ? params[:q][:s] : ''
    @products = @search.result.page(params[:page]).per(params[:limit])

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
