class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

  has_many :addresses
  has_many :orders, through: :addresses

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def default_address
    addresses.first
  end
end
