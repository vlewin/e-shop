FactoryGirl.define do
  factory :category do
    sequence(:title)   { |n| "#{Faker::Product.brand}#{n}" }
  end
end

