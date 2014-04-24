class OrderPolicy
  attr_reader :user, :record

  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope.all
      else
        user.orders
      end
    end
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    puts "*** #{self.class} index? => #{@user.admin?}"
    # @user.admin?
  end

  def edit?
    @user.admin?
  end

  def show?
    puts "*** #{self.class} show?"
    @user.admin? || @user.orders.find(@record)
  end

  def update?
    puts "*** #{self.class} update?"
    @user.admin?
  end

  def destroy?
    puts "*** #{self.class} destroy?"
    @user.admin?
  end

  # def scope
  #   Pundit.policy_scope!(@user, @record.class)
  # end

end