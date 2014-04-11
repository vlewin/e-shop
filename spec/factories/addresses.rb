# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    country "MyString"
    city "MyString"
    street "MyString"
    zip "MyString"
    phone "MyString"
    user_id "MyString"
  end
end
