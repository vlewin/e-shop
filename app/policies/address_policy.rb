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
    @user.admin? || @user.addresses.exists?(record.id)
  end

  def show?
    @user.admin? || @user.addresses.exists?(record.id)
  end

  # def new?
  #   @user.admin?
  # end

  # def create?
  #   @user.admin? || @user.addresses.exists?(record)
  # end

  def edit?
    @user.admin? || @user.addresses.exists?(record.id)
  end

  def update?
    @user.admin? || @user.addresses.exists?(record.id)
  end

  def delete?
    @user.admin? || @user.addresses.exists?(record.id)
  end

  def destroy?
    @user.admin? || @user.addresses.exists?(record.id)
  end
end
