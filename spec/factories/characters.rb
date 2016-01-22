FactoryGirl.define do
  factory :character do
    name {Faker::Name.name}
    history {Faker::Lorem.paragraph(3)}
    game
  end
end
