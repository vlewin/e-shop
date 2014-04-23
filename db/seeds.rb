user=User.where(:email => "customer@example.com").first_or_initialize
user.password = "password"
user.name = "Customer"
user.skip_confirmation!
user.save

address = Address.create(
    country: 'Germany',
    city:     Faker::Address.city,
    street:   Faker::Address.street_address,
    zip:      Faker::Address.zip_code,
    phone:    Faker::PhoneNumberDE.home_work_phone_number,
    user_id: user.id
)

admin_user=User.where(:email => "admin@example.com").first_or_initialize
admin_user.password = "password"
admin_user.name = "Admin"
admin_user.skip_confirmation!
admin_user.save
admin_user.admin!


5.times do |c|
  category = Category.create(:name => Faker::Product.brand)
  rand(3..6).times do |p|
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

DeliveryService.create(name: 'DHL Paket', rate: 6.99)
DeliveryService.create(name: 'DHL Päckchen', rate: 4.10)