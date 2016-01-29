FactoryGirl.define do
  factory :user do
    username 'example'
    email 'example@email.com'
    password 'password'
    roles 'Street Fighter V,Street Fighter IV,Tekken 7'

    trait :evil do
      username 'Satan'
      email 'saddams_gal@gehenna.net'
      password 'l0rd0fd4rkn3ss'
      roles 'Guilty Gear XRD,Smash Bros'
    end

    factory :evil_user, traits: [:evil]
  end
end
