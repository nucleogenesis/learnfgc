FactoryGirl.define do
  factory :question do
    title { Faker::Lorem.sentence(1) }
    content { Faker::Lorem.paragraph(2) }
  end
end
