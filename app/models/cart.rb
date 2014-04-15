class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id, quantity=1)
    puts "**** #{quantity.inspect}"

    current_item = line_items.find_by(product_id: product_id)

    if current_item
      current_item.quantity += quantity.to_i
    else
      current_item = line_items.build(product_id: product_id, quantity: quantity)
      current_item.price = current_item.product.price
    end
    current_item
  end

  def total
    line_items.to_a.sum { |item| item.total }
  end

  def count
    line_items.to_a.sum { |item| item.quantity }
  end

  # acts_as_shopping_cart_using :cart_item

  # def taxes
  #   (subtotal) * 10.0
  # end

  # def tax_pct
  #   10.0
  # end
end
