class AddressPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope.unscoped.all
      else
        user.addresses
      end
    end
  end

  def index?
    @user.admin? || @user.addresses.active.exists?(record)
  end

  def show?
    @user.admin? || @user.addresses.active.exists?(record)
  end

  # def new?
  #   @user.admin?
  # end

  # def create?
  #   @user.admin? || @user.addresses.exists?(record)
  # end

  def edit?
    @user.admin? || @user.addresses.active.exists?(record)
  end

  def update?
    @user.admin? || @user.addresses.active.exists?(record)
  end

  def delete?
    @user.admin? || @user.addresses.active.exists?(record)
  end

  def destroy?
    @user.admin?
  end
end
