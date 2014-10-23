# Users
user=User.where(:email => "customer@example.com").first_or_initialize
user.password = "password"
user.name = Faker::Name.name
user.skip_confirmation!
user.save

address = Address.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city:     Faker::Address.city,
    street:   Faker::Address.street_address,
    zip:      Faker::Address.zip_code,
    phone:    Faker::PhoneNumberDE.home_work_phone_number,
    user_id: user.id
)

admin_user=User.where(:email => "admin@example.com").first_or_initialize
admin_user.password = "password"
admin_user.name = "E-Shop Admin"
admin_user.skip_confirmation!
admin_user.save
admin_user.admin!

# Categories and products
5.times do |c|
  category = Category.create(:name => Faker::Product.brand)
  rand(1..4).times do |p|
    product = Product.create(
      name: Faker::Product.product,
      description: Faker::Lorem.sentence,
      article_number: Faker::Product.model,
      price: rand(1..25),
      quantity: rand(0..10),
      tax: 7
    )
    category.products << product
  end
end

# Shipments
Shipment.create(provider: 'OH', name: 'Home Delivery', fee: 0.00, default: true) unless Shipment.find_by_name('Home Delivery')

# Orders
order = user.orders.create({
  shipping_address_id: user.addresses.first.id,
  shipment_id: Shipment.first.id,
  pay_type: 'Purchase order',
  status: 'shipped'
})

order.line_items << LineItem.create(product_id: Product.first.id, quantity: Product.first.quantity, price: Product.first.price)
