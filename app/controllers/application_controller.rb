class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  # private

  # def user_not_authorized
  #   flash[:alert] = "Access denied."
  #   begin
  #     redirect_to root_path and return
  #   rescue Exception => e
  #     puts e.inspect
  #   end
  # end

end
