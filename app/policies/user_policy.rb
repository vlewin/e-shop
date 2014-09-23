class UserPolicy
  attr_reader :user, :record

  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(:id => user.id)
      end
    end
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.admin?
  end

  def edit?
    @user == record
  end

  def show?
    @user.admin? || @user == record
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end
end
