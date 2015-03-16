class Cart < ActiveRecord::Base
  belongs_to :shipment
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  class << self
    def purge
      Cart.where("updated_at  <?", 2.hours.ago).destroy_all
    end
  end

  def add_item(product_id, quantity)
    quantity = quantity.to_i
    line_item = line_items.find_by(product_id: product_id)

    if line_item
      quantity = line_item.quantity + quantity
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

    if quantity <= line_item.max_quantity
      ActiveRecord::Base.transaction do
        line_item.product.update(reserved_count: quantity)
        line_item.update_attributes(quantity: quantity)
      end
    end
  end

  def empty?
    line_items.count.zero?
  end

  def count
    line_items.sum(:quantity)
  end

  def subtotal
    line_items.to_a.sum { |item| item.total }
  end

  def total
    line_items.to_a.sum { |item| item.total } + shipping
  end

  def taxes
    line_items.to_a.sum { |item| item.tax }
  end

  def shipping
    shipment.try(:fee) || Shipment.default.fee
  end
end
