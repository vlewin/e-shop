class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id, quantity=1)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      if current_item.quantity
        current_item.quantity += quantity.to_i.zero? ? 1 : quantity.to_i
      else
        current_item.quantity = quantity
      end
    else
      current_item = line_items.build(product_id: product_id, quantity: quantity)
      current_item.price = current_item.product.price
    end
    current_item
  end

  def empty?
    line_items.count.zero?
  end

  def subtotal
    line_items.to_a.sum { |item| item.subtotal }
  end

  def total
    line_items.to_a.sum { |item| item.total } + Shipment.first.rate # + Default shipping cost
  end

  def count
    line_items.sum(:quantity)
  end

  def taxes
    line_items.to_a.sum { |item| item.tax }
  end
end
