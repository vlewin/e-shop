class StoreController < ApplicationController
  respond_to :html, :js

  skip_before_filter :authenticate_user!

  def index
    @search = Product.search(params[:q])
    @products = @search.result.page(params[:page])
    @categories = Category.all

    redirect_to root_url(locale: params[:set_locale]) if params[:set_locale]
  end

  def show
    @product = Product.find(params[:id])
  end

  # def language
  #   redirect_to root_url(locale: params[:set_locale]) if params[:set_locale]
  #   # redirect_to_back_or_default(locale: params[:set_locale])
  # end
end
