class ProductPolicy < ApplicationPolicy
  # Public
  def index?
  end

  def show?
  end

  # Protected
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

