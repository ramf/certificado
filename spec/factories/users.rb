FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456' }
    role_id { User.role_ids['admin'] }
  end
end
