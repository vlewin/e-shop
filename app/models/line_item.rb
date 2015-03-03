class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  after_create :increase_product_reserved_count
  before_destroy :descrease_product_reserved_count

  def max_quantity
    quantity + product.available_quantity
  end

  def total
    subtotal + tax
  end

  def subtotal
    (product.price * quantity)
  end

  def tax
    subtotal * (product.vat.rate / 100)
  end

  private

  def increase_product_reserved_count
    product.update(reserved_count: quantity)
  end

  def descrease_product_reserved_count
    product.update(reserved_count: product.reserved_count - quantity)
  end
end
