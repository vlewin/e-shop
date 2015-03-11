class AccountController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, only: [:show]

  def show
    @user = current_user
    authorize @user
  end
end
