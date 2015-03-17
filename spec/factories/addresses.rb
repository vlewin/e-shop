FactoryGirl.define do
  factory :address do
    recipient     "#{FFaker::NameDE.first_name} #{FFaker::NameDE.last_name}"
    city          FFaker::AddressDE.city
    street        FFaker::AddressDE.street_address
    zip_code      FFaker::AddressDE.zip_code
    phone         FFaker::PhoneNumberDE.mobile_phone_number

    association :user, factory: :user
  end
end

