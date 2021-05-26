FactoryBot.define do
  factory :item do
    sequence :id
    description { Faker::Company.bs }
    unit_price { Faker::Number.number(digits: 5) }
    merchant
    sequence :name do |n|
      "item-#{n}"
    end
  end
end
