class CategoryPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def edit?
    puts "*** #{self.class} edit? => #{@user.admin?}"
    @user.admin?
  end

  def new?
    puts "*** #{self.class} new? => #{@user.admin?}"
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def update?
    puts "*** #{self.class} update? => #{@user.admin?}"
    @user.admin?
  end

  def destroy?
    puts "*** #{self.class} destroy? => #{@user.admin?}"
    @user.admin?
  end
end
