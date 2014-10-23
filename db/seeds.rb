# Users
user = FactoryGirl.create(:user, email: 'customer@example.com')
admin = FactoryGirl.create(:admin)
address = FactoryGirl.create(:address, user: user)

# Categories and products
5.times do |c|
  category = Category.create(name: Faker::Product.brand)
  rand(1..4).times do |p|
    product = Product.create(
      name: Faker::Product.product,
      description: Faker::Lorem.sentence,
      ean: Faker::Product.model,
      price: rand(1..25),
      quantity: rand(0..10),
      vat: 7
    )
    category.products << product
  end
end

shipment = FactoryGirl.create(:shipment, provider: 'OH', name: 'Home Delivery', fee: 0, default: true)
FactoryGirl.create(:order, user: user, address: address, shipment: shipment, status: 'shipped')

# order.line_items << LineItem.create(product_id: Product.first.id, quantity: Product.first.quantity, price: Product.first.price)
