FactoryGirl.define do
  factory :line_item do
    quantity    1
    price       5

    association :product

    factory :cart_item do
      association :cart
    end

    factory :order_item do
      association :order
    end
  end
end
