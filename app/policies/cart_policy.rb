class CartPolicy < ApplicationPolicy
  def index?
    @user.admin?
  end

  # def show?
  #   @user.admin?
  # end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      if user && user.admin?
        scope.all
      else
        scope
      end
    end
  end
end
