FactoryGirl.define do
  factory :category do
    name Faker::Product.brand
    description Faker::Lorem.sentence
  end
end

