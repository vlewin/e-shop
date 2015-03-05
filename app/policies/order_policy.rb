class OrderPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope.all
      else
        user.orders
      end
    end
  end

  def index?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def show?
    @user.admin? || @user.orders.exists?(record.id)
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end
end
