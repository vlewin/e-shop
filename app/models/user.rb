class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable


  # has_many :billing_addresses, :class_name => "Address"
  # has_many :shipping_addresses, :class_name => "Address"

  belongs_to :billing_address, :class_name => "Address"
  belongs_to :shipping_address, :class_name => "Address"

#  has_many :addresses
  # has_many :orders, through: :addresses

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def default_address
    addresses.default.first
  end
end


# EXAMPLE

# http://codereview.stackexchange.com/questions/25963/how-do-i-refactor-this-activerecord-object-to-lessen-dependency-on-callbacks
# validates :shipping_address, presence: true, unless: :ship_to_billing_address?

# class Order < ActiveRecord::Base
#   attr_accessor :bill_to_shipping_address

#   belongs_to :billing_address,  class_name: 'Address'
#   belongs_to :shipping_address, class_name: 'Address'

#   accepts_nested_attributes_for :billing_address, :shipping_address

#   after_initialize  :set_billing_to_shipping_address
#   before_validation :set_billing_address
#   after_validation  :clear_billing_address_errors

#   # Init the object with option checked
#   def set_billing_to_shipping_address
#     self.bill_to_shipping_address ||= '1'
#   end

#   # Copy shipping address attrs to billing address
#   def set_billing_address
#     self.billing_address = self.shipping_address if bill_to_shipping_address?
#   end

#   def bill_to_shipping_address?
#     bill_to_shipping_address == '1'
#   end

#   # If shipping address matches billing, we copy the attrs, and thus duplicate errors too.
#   # We only need to show the user one set of errors if addresses are the same, so remove them for billing address.
#   def clear_billing_address_errors
#     if bill_to_shipping_address?
#       self.errors.messages.each { |k,v| self.errors.messages.delete(k) if k.to_s.split('.')[0] == 'billing_address' }
#     end
#   end
# end
