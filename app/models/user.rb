class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :addresses
  has_many :orders, through: :addresses

  def set_default_role
    self.role ||= :user
  end
end
