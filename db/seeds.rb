# Users
user = FactoryGirl.create(:user, email: 'customer@example.com')
admin = FactoryGirl.create(:admin)
address = FactoryGirl.create(:address, user: user)

# Categories and products
4.times do |c|
  category = FactoryGirl.create(:category)
  rand(1..4).times do |int|
    category.products << FactoryGirl.create(:product, category: category)
  end
end

shipment = FactoryGirl.create(:shipment, provider: 'OH', title: 'Home Delivery', fee: 0, default: true)
FactoryGirl.create(:order, user: user, address: address, shipment: shipment, status: 'shipped')
