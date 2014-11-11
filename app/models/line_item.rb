class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart

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

end
