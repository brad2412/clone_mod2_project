FactoryBot.define do
  factory :invoice_item do
    unit_price { Faker::Number.between(from: 1000, to: 10000) }
    quantity { Faker::Number.within(range: 1..10) }
    status { Faker::Number.within(range: 0..2) }
    association :item
    association :invoice
  end
end