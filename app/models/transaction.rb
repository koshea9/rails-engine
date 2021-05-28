class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true
  validates :credit_card_expiration_date, presence: true
  validates :result, presence: true

  belongs_to :invoice
  has_many :invoice_items, through: :invoice
  has_one :customer, through: :invoice
  has_one :merchant, through: :invoice
  has_many :items, through: :invoice_items
end
