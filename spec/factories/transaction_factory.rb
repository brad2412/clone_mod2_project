FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { Faker::Number.number(digits: 2).to_s +"/"+Faker::Number.number(digits: 2).to_s }
    result { "success" }
    association :invoice
  end
end