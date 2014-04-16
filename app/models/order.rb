class Order < ActiveRecord::Base
  PAYMENT_TYPES = [ 'Bank transfer', 'Purchase order' ]
  has_many :line_items, dependent: :destroy
  belongs_to :address

  validates :address_id, :pay_type, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
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

