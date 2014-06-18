FactoryGirl.define do
  factory :order do
    pay_type  'Purchase order'
    status    :accepted

    association :address, factory: :address
    association :shipment, factory: :shipment

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
