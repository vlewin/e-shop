class InvitationsController < Devise::InvitationsController
  include FastGettext::Translation
  before_filter :authorize!, only: [:new]
  before_filter :update_sanitized_params, only: :update

  protected

  def after_invite_path_for(resource)
    redirect_to users_path
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:name, :password, :password_confirmation, :invitation_token, :avatar, :avatar_cache)
    end
  end

  private
  def authorize!
    raise Pundit::NotAuthorizedError unless current_user && current_user.admin?
  end
end
