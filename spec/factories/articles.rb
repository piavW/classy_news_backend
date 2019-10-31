FactoryBot.define do
  factory :article do
    title { "TitleString" }
    content { "ContentText" }
    author { "AuthorString" }
    association :journalist, factory: :user
  end
end
