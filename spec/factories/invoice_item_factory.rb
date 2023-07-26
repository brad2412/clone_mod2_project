FactoryBot.define do
  factory :invoice_item do
    unit_price { Faker::Number.number.digits(5) }
    quantity { Faker::Number.number.within(range: 1..10) }
    status { "shipped" }
    association :item
    association :invoice
  end
end