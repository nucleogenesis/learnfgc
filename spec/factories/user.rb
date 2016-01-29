FactoryGirl.define do
  factory :user do
    username 'example'
    email 'example@email.com'
    password 'password'
    roles 'Street Fighter V,Street Fighter IV,Tekken 7'
  end
end
