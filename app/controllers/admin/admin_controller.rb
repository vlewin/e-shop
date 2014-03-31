module Admin
  class AdminController < ApplicationController
    before_filter :authenticate_user!
    before_action :verify_authorized, :except => [:index, :show]
  end
end
