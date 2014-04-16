class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  def total
    subtotal + tax
  end

  def subtotal
    (product.price * quantity)
  end

  def tax
    subtotal * (product.tax / 100)
  end

end
