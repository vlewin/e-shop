class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
    authorize :users, :index?

    @items = find_and_paginate(order: 'name ASC')
    render(partial: 'users', layout: false) and return if request.xhr?
  end

  def show
    @user = current_user.admin? ? User.find(params[:id]) : current_user
    authorize current_user
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user

    if @user.destroy
      redirect_to users_path
    else
      redirect_to users_path, alert: "#{@product.errors.full_messages.join(', ')}"
    end
  end
end
