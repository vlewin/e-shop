FactoryGirl.define do
  factory :shipment do
    provider  'DHL'
    name      'Paket'
    fee       6.99
    default true
  end
end

