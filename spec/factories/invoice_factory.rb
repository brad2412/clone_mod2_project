FactoryBot.define do
  factory :invoice do
    status { "completed"}
    association :customer
  end
end