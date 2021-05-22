FactoryBot.define do
  factory :item do
    name { "item #{Faker::Commerce.product_name}" }
    description { Faker::Company.bs }
    unit_price { Faker::Number.number(digits: 5) }
    merchant
  end
end
