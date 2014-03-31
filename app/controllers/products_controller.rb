class ProductsController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, except: [:index, :show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
