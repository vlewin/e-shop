class ProductsController < ApplicationController
  add_breadcrumb 'Products', "#{controller_name}_path".to_sym

  before_filter :authenticate_user!

  before_action :set_product, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, :except => [:index, :show]

  def index
    @search = Product.search(params[:q])

    if params[:q].nil?
      @products = @search.result(:distinct => true).order('created_at DESC')
    else
      @products = @search.result(:distinct => true)
    end

    # @search = Product.search(params[:q])
    @products = @search.result
    @categories = Category.all
  end

  def show
  end

  def new
    add_breadcrumb "New #{controller_name.singularize}"

    @product = Product.new
    @categories = Category.all
    authorize @product
  end

  def edit
    @categories = Category.all
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.category = Category.find(params[:category_id])
    authorize @product

    if @product.save!
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    authorize @product

    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    authorize @product

    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
    add_breadcrumb @product.name
  end

  # Only allow a trusted parameter "white list" through.
  def product_params
    params.require(:product).permit(
      :article_number,
      :name,
      :description,
      :quantity,
      :price,
      :tax,
      :category_id
    )
  end

end
