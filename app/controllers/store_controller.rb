class StoreController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    redirect_to root_url(locale: params[:set_locale]) if params[:set_locale]
  end

  # def language
  #   redirect_to root_url(locale: params[:set_locale]) if params[:set_locale]
  #   # redirect_to_back_or_default(locale: params[:set_locale])
  # end
end
