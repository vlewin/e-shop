FactoryGirl.define do
  factory :category do
    sequence(:title)   { |n| "#{Faker::Product.brand}#{n}" }

    after :build do |category, evaluator|
      category.products << FactoryGirl.create(:product, category: category)
    end
  end
end

