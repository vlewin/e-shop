class AccountController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def show
    add_breadcrumb "Home", :root_path
    add_breadcrumb 'Account settings', account_url

    @user = current_user
    @address = Address.new

    authorize current_user
  end
end
