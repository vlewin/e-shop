FactoryGirl.define do
  factory :order do
    association :user
    association :address
    association :shipment
    association :payment

    status    :accepted

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
