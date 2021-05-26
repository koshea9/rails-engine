FactoryBot.define do
  factory :invoice do
    status { rand(0..2) }
    customer
    merchant


    factory :shipped_invoice do
      status { "shipped" }

    factory :not_shipped_invoice do
      status { ["packaged","returned"].sample }
    end
  end
  end
end
