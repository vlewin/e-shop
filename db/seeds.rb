user=User.where(:email => "customer@mail.com").first_or_initialize
user.password = "password"
user.name = "Customer"
user.skip_confirmation!
user.save

user=User.where(:email => "admin@mail.com").first_or_initialize
user.password = "password"
user.name = "Admin"
user.skip_confirmation!
user.save
user.admin!


10.times do |c|
  category = Category.create(:name => "Category #{c}")
  3.times do |p|
    part_number = Product.last ? (Product.last.id + 1000) : 1001
    product = Product.create(part_number: part_number, title: "Product #{c+p}", name: "Product #{c+p}", amount: '1 kg', price: rand(25), vat: 7)
    category.products << product
  end
end
