class ProductPolicy
  attr_reader :user, :record

  # class Scope < Struct.new(:user, :scope)
  #   def resolve
  #     if user.admin?
  #       scope.all
  #     else
  #       scope.where(:id => user.id)
  #     end
  #   end
  # end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def new?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

  # def scope
  #   Pundit.policy_scope!(@user, @record.class)
  # end

end
