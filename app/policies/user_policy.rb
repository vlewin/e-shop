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
    puts "***************************** INDEX"
    @user.admin?
  end

  def show?
    @user.admin? || scope.exists?
  end

  def update?
    puts "***************************** UPDATE"
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

  def scope
    Pundit.policy_scope!(@user, @record.class)
  end

end
