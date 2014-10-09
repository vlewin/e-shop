FactoryGirl.define do
  factory :address do
    first_name    Faker::Name.first_name
    last_name     Faker::Name.last_name
    city          Faker::Address.city
    street        Faker::Address.street_address
    zip           Faker::Address.zip_code
    phone         Faker::PhoneNumberDE.home_work_phone_number

    association :user, factory: :user
  end
end

