class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  def total
    subtotal + (subtotal * (product.tax / 100))
  end

  def subtotal
    (product.price * quantity)
  end

end
