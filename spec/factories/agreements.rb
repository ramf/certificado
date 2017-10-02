
FactoryGirl.define do
  factory :agreement do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    user
  end
end
