FactoryGirl.define do
  factory :user, :class => User do
    sequence(:name)  { |n| "Customer#{n}" }
    sequence(:email)  { |n| "email#{n}@factory.com" }
    password               'password'
    password_confirmation  'password'

    initialize_with do
      User.find_or_create_by(name: name, email: email)
    end

    after :build do |user|
      user.confirm!
    end

    factory :admin do
      name      'E-Shop Admin'
      email     'admin@factory.com'

      after :build do |user|
        user.admin!
      end
    end

    factory :user_with_addresses do
      ignore do
        count 2
      end

      after(:create) do |user, evaluator|
        create_list(:address, evaluator.count, user: user)
      end
    end
  end

end

