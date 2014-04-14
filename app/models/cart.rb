class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id)
    current_item = line_items.find_by(product_id: product_id)

    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
      current_item.price = current_item.product.price
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def total_count
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
