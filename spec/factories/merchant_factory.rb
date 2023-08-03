FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    enabled { Faker::Number.within(range: 0..1) }
  end
end

