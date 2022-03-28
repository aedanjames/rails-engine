FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    author { Faker::Name.last_name }
  end
end