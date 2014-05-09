user=User.where(:email => "customer@example.com").first_or_initialize
user.password = "password"
user.name = "Happy Customer"
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
admin_user.name = "E-Shop Admin"
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

Shipment.create(provider: 'DHL', name: 'Paket',    rate: 6.99, default:true)
Shipment.create(provider: 'DHL', name: 'Päckchen', rate: 4.10)
