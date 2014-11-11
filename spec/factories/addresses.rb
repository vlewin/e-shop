FactoryGirl.define do
  factory :address do
    recipient     "#{Faker::NameDE.first_name} #{Faker::NameDE.last_name}"
    city          Faker::AddressDE.city
    street        Faker::AddressDE.street_address
    zip_code      Faker::AddressDE.zip_code
    phone         Faker::PhoneNumberDE.mobile_phone_number

    association :user, factory: :user
  end
end

