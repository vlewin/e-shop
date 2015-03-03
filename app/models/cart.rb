class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  def add_item(product_id, quantity)
    line_item = line_items.find_by(product_id: product_id)

    if line_item
      quantity = line_item.quantity + quantity.to_i
      update_item(line_item.id, quantity)
    else
      product = Product.find(product_id)
      line_item = line_items.create(product_id: product.id, price: product.price, quantity: quantity)
    end

    line_item
  end

  def update_item(line_item_id, quantity)
    quantity = quantity.to_i
    line_item = line_items.find(line_item_id)
    line_item.update_attributes(quantity: quantity) if quantity <= line_item.max_quantity
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
