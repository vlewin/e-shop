class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all
    authorize @users
  end

  def show
    add_breadcrumb current_user.name

    @user = current_user
    authorize current_user
  end
end
