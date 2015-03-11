class Address < ActiveRecord::Base
  belongs_to :user
  has_many :billing_orders, class_name: 'Order', foreign_key: :billing_address_id
  has_many :shipping_orders, class_name: 'Order', foreign_key: :shipping_address_id

  validates :recipient, :city, :street, :zip_code, :phone, :user_id,  presence: true

  before_destroy :ensure_not_referenced_by_any_order

  enum status: { active: 0, inactive: 1 }

  scope :active, -> { where(status: statuses[:active]) }
  scope :inactive, -> { where(status: statuses[:inactive]) }

  def orders
    Order.where('billing_address_id=? OR shipping_address_id=?', id, id)
  end

  def full_address
    "#{recipient}, #{street}, #{zip_code} #{city}"
  end

  def in_use?
    orders.exists?
  end

  private
  # Ensure that there are no orders referencing this address
  def ensure_not_referenced_by_any_order
    if in_use?
      errors.add(:address, 'is referenced by an order')
      return false
    else
      return true
    end
  end
end

