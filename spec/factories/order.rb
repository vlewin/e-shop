FactoryGirl.define do
  factory :order do
    pay_type  'Purchase order'
    status    :accepted

    association :user,      factory: :user
    association :address,   factory: :address
    association :shipment,  factory: :shipment

    after :build do |order, evaluator|
      order.line_items << FactoryGirl.create(:order_item, order: order)
    end

    factory :order_in_progress do
      status :in_progress
    end

    factory :order_shipped do
      status :shipped
    end

    factory :order_completed do
      status :completed
    end
  end
end
