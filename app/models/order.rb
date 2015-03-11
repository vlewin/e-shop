class Order < ActiveRecord::Base
  enum status: [ :accepted, :in_progress, :shipped, :completed ]

  belongs_to :user
  belongs_to :shipment
  belongs_to :payment

  belongs_to :address, foreign_key: :shipping_address_id
  belongs_to :billing_address, class_name: 'Address', foreign_key: :billing_address_id
  belongs_to :shipping_address, class_name: 'Address', foreign_key: :shipping_address_id

  has_many :line_items, -> { includes(product: [:vat]) }, dependent: :destroy

  validates :shipping_address_id, :shipment_id, :payment_id, presence: true

  before_create :set_billing_address

  def set_billing_address
    self.billing_address_id = shipping_address_id  if billing_address_id.nil?
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
    line_items.to_a.sum(&:subtotal)
  end

  def total
    line_items.to_a.sum { |item| item.total } + shipment.fee
  end

  def count
    line_items.to_a.sum(&:quantity)
  end

  def taxes
    line_items.to_a.sum(&:tax)
  end
end
