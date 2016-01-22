FactoryGirl.define do
  factory :character do
    name "Fighter Guy"    
    history Faker::Lorem.paragraph(2)
    game
  end
end
