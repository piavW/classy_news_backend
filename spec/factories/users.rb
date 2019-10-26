FactoryBot.define do
  factory :user do
    name { "Luca" }
    email { "user@mail.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
