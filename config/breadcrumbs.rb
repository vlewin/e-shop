crumb :root do
  link _('Home'), root_path
end

crumb :product do |product|
  link product.title
end

crumb :cart do |cart|
  ap cart
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
  ap current_user.admin?

  link "Order ##{order.id}", account_path
  if current_user.admin?
    parent :orders
  else
    parent :account
  end
end

# Admin crumbs
crumb :orders do
  link _('Orders'), orders_path
end

