class HomeController < ApplicationController
  before_filter :current_cart

  def index
  end
end
