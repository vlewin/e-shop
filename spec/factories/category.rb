FactoryGirl.define do
  factory :category do
    sequence(:title)   { |n| "#{FFaker::Product.brand}#{n}" }
  end
end

