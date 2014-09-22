FactoryGirl.define do
  factory :shipment do
    provider  'DHL'
    name      'Paket'
    rate       6.99
    default true
  end
end

