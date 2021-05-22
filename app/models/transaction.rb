class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number
  validates_presence_of :credit_card_expiration_date
  validates_presence_of :result

  belongs_to :invoice
  has_many :invoice_items, through: :invoice
  has_one :customer, through: :invoice
  has_one :merchant, through: :invoice
  has_many :items, through: :invoice_items

  enum result: [ 'failed', 'refunded', 'success' ]
end
