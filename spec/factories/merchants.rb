FactoryBot.define do
  factory :merchant do
    sequence :name do |n|
      "merchant-#{n}"
    end
  end
end
