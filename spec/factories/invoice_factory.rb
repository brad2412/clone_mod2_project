FactoryBot.define do
  factory :invoice do
    status { "completed"}
    association :customer
    association :invoice_item
  end
end