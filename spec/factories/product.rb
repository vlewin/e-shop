FactoryGirl.define do
  factory :product do
    sequence(:title)   { |n| "#{Faker::Product.product}#{n}" }
    ean             Faker.numerify('#####')
    description     Faker::Lorem.sentence
    quantity        2
    price           5

    association :category

    after :build do |product, evaluator|
      product.vat = Vat.find_or_create_by(title: 'normal', rate: 19)
    end
  end
end

