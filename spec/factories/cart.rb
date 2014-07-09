FactoryGirl.define do
  factory :cart do
    after :build do |cart, evaluator|
      cart.line_items << FactoryGirl.create(:cart_item, cart: cart)
    end

    factory :empty_cart do
      after(:build)  { |cart| cart.line_items.destroy_all }
    end
  end
end
