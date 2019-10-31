FactoryBot.define do
  factory :article do
    title { "TitleString" }
    content { "ContentText" }
    author { "AuthorString" }
    association :journalist, factory: :user

  after(:create) do |article|
    article.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'testimage.png')),
    filename: 'attachment.png',
    content_type: 'image/png')
  end
end
end
