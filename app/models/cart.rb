class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id, quantity=1)
    line_item = line_items.find_by(product_id: product_id)

    if line_item
      line_item.quantity += quantity.to_i.zero? ? 1 : quantity.to_i
    else
      product = Product.find(product_id)
      line_item = line_items.build(product_id: product_id, quantity: quantity, price: product.price)
    end

    line_item
  end

  def empty?
    line_items.count.zero?
  end

  def subtotal
    line_items.to_a.sum { |item| item.subtotal }
  end

  def total
    line_items.to_a.sum { |item| item.total } + Shipment.default.fee # + Default shipping cost
  end

  def count
    line_items.sum(:quantity)
  end

  def taxes
    line_items.to_a.sum { |item| item.tax }
  end
end
