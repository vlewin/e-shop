FactoryGirl.define do
  factory :category do
    name Faker::Product.brand
    description Faker::Lorem.sentence

    after :build do |category, evaluator|
      category.products << FactoryGirl.create(:product, category: category)
    end
  end
end

