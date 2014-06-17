FactoryGirl.define do
  factory :product do
    name            Faker::Product.product
    article_number  Faker.numerify('#####')
    description     Faker::Lorem.sentence
    quantity        2
    price           5
    tax             20

    association :category, factory: :category
  end
end

