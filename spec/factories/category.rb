FactoryGirl.define do
  factory :category do
    sequence(:title)   { |n| "#{Faker::Product.brand}#{n}" }
    description Faker::Lorem.sentence

    after :build do |category, evaluator|
      category.products << FactoryGirl.create(:product, category: category)
    end
  end
end

