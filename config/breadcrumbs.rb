crumb :root do
  link _('E-Shop'), root_path
end

crumb :product do |product|
  link product.title
end

crumb :cart do |cart|
  link _('Your Cart'), cart_path(current_cart)
end

crumb :checkout do
  link _('Checkout')
  parent :cart
end

crumb :account do
  link _('My Account'), account_path
end

crumb :order do |order|
  unless current_user.admin?
    link "Order ##{order.id}", account_path
    parent :account
  end
end

