class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id, quantity=1)
    quantity = quantity.to_i.zero? ? 1 : quantity.to_i

    product = Product.find(product_id)
    line_item = line_items.find_by(product_id: product.id)

    if line_item
      line_item.quantity += quantity
    else
      line_items.create(product_id: product.id, quantity: quantity, price: product.price)
    end
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
