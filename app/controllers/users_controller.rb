class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized
  after_action :verify_policy_scoped, :only => :index
  # before_action :verify_authorized

  # def index
  #   @users = policy_scope(User)
  #   authorize @users
  # end

  def show
    # @user = policy_scope(User).find(params[:id])
    # FIXME: Pundit scope => nil
    @user = policy_scope(User).where(:id => params[:id]).first
    authorize @user if @user

  end

  # def edit
  # end

  # def update
  #   puts "************ UPDATE USER"
  #   @user = policy_scope(User).find(params[:id])
  #   authorize @user

  #   if @user.update_attributes(user_params)
  #     redirect_to users_path, :notice => "User updated."
  #   else
  #     redirect_to users_path, :alert => "Unable to update user."
  #   end
  # end

  # def destroy
  #   user = policy_scope(User).find(params[:id])
  #   authorize user

  #   unless user == current_user
  #     user.destroy
  #     redirect_to users_path, :notice => "User deleted."
  #   else
  #     redirect_to users_path, :notice => "Can't delete yourself."
  #   end
  # end

  private

  def user_params
    # params.require(:user).permit(:role)
  end

end
