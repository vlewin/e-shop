FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "#{Faker::Product.product}#{n}" }

    article_number  Faker.numerify('#####')
    description     Faker::Lorem.sentence
    quantity        2
    price           5
    tax             20

    association :category
  end
end

