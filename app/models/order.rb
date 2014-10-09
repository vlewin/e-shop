class Order < ActiveRecord::Base
  PAYMENT_TYPES = [ 'Bank transfer', 'Purchase order' ]
  enum status: [ :accepted, :in_progress, :shipped, :completed ]

  belongs_to :user
  belongs_to :shipment

  # has_one :user, :through => :address
  belongs_to :address, foreign_key: :shipping_address_id
  belongs_to :billing_address, class_name: 'Address', foreign_key: :billing_address_id

  has_many :line_items, dependent: :destroy

  validates :shipping_address_id, :shipment_id, :pay_type, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  before_create :set_billing_address

  def set_billing_address
    billing_address_id = shipping_address_id  if billing_address_id.nil?
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      line_item = item.dup
      line_item.product.decrease_quantity line_item.quantity
      line_item.cart_id = nil
      line_item.save!
      line_items << line_item
    end
  end

  def subtotal
    line_items.to_a.sum { |item| item.subtotal }
  end

  def total
    line_items.to_a.sum { |item| item.total } + shipment.rate
  end

  def count
    line_items.to_a.sum { |item| item.quantity }
  end

  def taxes
    line_items.to_a.sum { |item| item.tax }
  end
end
