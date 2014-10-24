class AddressPolicy < ApplicationPolicy
  def index?
    @user.admin?
  end

  def show?
    @user.admin? || @user.addresses.exists?(record)
  end

  def new?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end
end
