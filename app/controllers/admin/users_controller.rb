class Admin::UsersController < Admin::AdminController
  # after_action :verify_authorized #, except: [:show]

  def index
    @users = policy_scope(User)
    authorize @users
  end

  def show
    @user = policy_scope(User).find(params[:id])
  end

  def edit
  end

  def update
    @user = policy_scope(User).find(params[:id])
    authorize @user

    if @user.update_attributes(user_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = policy_scope(User).find(params[:id])
    authorize user

    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end

end
