FactoryGirl.define do
  factory :question_comment do
    content { Faker::Lorem.paragraph(2) }
  end
end
