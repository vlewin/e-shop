class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:set_locale]
      redirect_to root_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end

  def language
    redirect_to root_url(locale: params[:set_locale]) if params[:set_locale]
  end
end
