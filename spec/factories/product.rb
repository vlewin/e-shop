FactoryGirl.define do
  factory :product do
    sequence(:title)   { |n| "#{Faker::Product.product}#{n}" }
    ean             Faker.numerify('#####')
    description     Faker::Lorem.sentence
    quantity        2
    price           5

    association :category
    association :vat
  end
end

