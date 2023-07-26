FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    # association :item
  end
end

