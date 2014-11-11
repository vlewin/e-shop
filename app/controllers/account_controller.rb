class AccountController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, only: [:show]

  def show
    @user = current_user
    @addresses = current_user.addresses.active
    authorize @user
  end
end
