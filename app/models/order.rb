class Order < ActiveRecord::Base
  PAYMENT_TYPES = [ 'Bank transfer', 'Purchase order' ]
  enum status: [ :accepted, :in_progress, :shipped, :completed ]

  belongs_to :address
  belongs_to :shipment

  has_one :user, :through => :address
  has_many :line_items, dependent: :destroy

  validates :address_id, :shipment_id, :pay_type, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  # validates :status, inclusion: [ :accepted, :in_progress, :shipped, :completed ]

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
    line_items.to_a.sum { |item| item.total }
  end

  def count
    line_items.to_a.sum { |item| item.quantity }
  end

  def taxes
    line_items.to_a.sum { |item| item.tax }
  end

end

