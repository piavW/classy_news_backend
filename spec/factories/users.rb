FactoryBot.define do
  factory :user do
    nickname { "Luca" }
    email { "user@mail.com" }
    city { "city" }
    country { "country" }
    password { "password" }
    password_confirmation { "password" }
    role { "subscriber" }
  end
end
