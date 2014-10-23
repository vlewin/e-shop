FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "#{Faker::Product.product}#{n}" }

    ean  Faker.numerify('#####')
    description     Faker::Lorem.sentence
    quantity        2
    price           5
    vat             20

    association :category
  end
end

