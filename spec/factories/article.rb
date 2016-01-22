FactoryGirl.define do
  factory :article do
    title "Factory Girl Article Title"
    content "Factory Girl Article Content"
    user

    trait :random do
      title {Faker::Lorem.sentence}
      content {Faker::Lorem.paragraphs(5)}
    end

    factory :random_article, traits: [:random]
  end
end
