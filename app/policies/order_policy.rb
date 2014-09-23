class OrderPolicy < ApplicationPolicy
  def index?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def show?
    @user.admin? || @user.orders.find(@record)
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope.all
      else
        user.orders
      end
    end
  end
end
