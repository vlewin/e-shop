class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def language
    redirect_to_back_or_default
  end
end
