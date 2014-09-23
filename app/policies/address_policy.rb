class AddressPolicy < ApplicationPolicy
  # Public
  def show?
    @user.admin? || @user.addresses.find(@record)
  end

  # Protected
  def index?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def new?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end
end
