class Cart < ActiveRecord::Base
  acts_as_shopping_cart_using :cart_item

  def taxes
    (subtotal) * 10.0
  end

  def tax_pct
    10.0
  end
end
