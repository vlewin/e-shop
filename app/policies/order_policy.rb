class OrderPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

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
    @user.admin? || @user.orders.exists?(record)
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end
end
