FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result { rand(0..2) }

    factory :successful_transaction do
      result { 'success' }

      factory :unsuccessful_transaction do
        result { %w[failed refunded].sample }
      end
    end
  end
end
