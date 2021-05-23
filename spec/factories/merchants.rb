FactoryBot.define do
  factory :merchant do
    sequence :id
    sequence :name do |n|
      "merchant-#{n}"
    end
  end
end
