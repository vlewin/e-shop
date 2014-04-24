class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = current_user.admin? ? User.find(params[:id]) : current_user
    authorize current_user
  end
end
