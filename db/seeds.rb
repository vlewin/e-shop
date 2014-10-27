# Users
user = FactoryGirl.create(:user, email: 'customer@example.com')
admin = FactoryGirl.create(:admin)
address = FactoryGirl.create(:address, user: user)

# Categories and products
5.times do |c|
  category = FactoryGirl.create(:category)
  # rand(1..4).times do |int|
  #   category.products << FactoryGirl.create(:product)

  #   # product = Product.create(
  #   #   title: "#{category.title} #{Faker::Product.product_name}",
  #   #   description: Faker::Lorem.sentence,
  #   #   ean: Faker::Product.model,
  #   #   price: rand(1..25),
  #   #   quantity: rand(0..10),
  #   #   vat: FactoryGirl.create(:vat)
  #   # )
  #   # category.products << product
  # end
end

shipment = FactoryGirl.create(:shipment, provider: 'OH', title: 'Home Delivery', fee: 0, default: true)
FactoryGirl.create(:order, user: user, address: address, shipment: shipment, status: 'shipped')

# order.line_items << LineItem.create(product_id: Product.first.id, quantity: Product.first.quantity, price: Product.first.price)
