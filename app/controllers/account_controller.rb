class AccountController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def show
    @user = current_user
    @address = Address.new
    authorize current_user
  end
end
