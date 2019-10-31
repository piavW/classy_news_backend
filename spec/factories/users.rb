FactoryBot.define do
  factory :user do
    nickname { Faker::Name.first_name }
    email { Faker::Internet.email }
    city { "city" }
    country { "country" }
    password { "password" }
    password_confirmation { "password" }
    role { "subscriber" }
  end
end
