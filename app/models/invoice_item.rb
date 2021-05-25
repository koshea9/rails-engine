class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true

  belongs_to :invoice
  belongs_to :item
  has_many :transactions, through: :invoice
end
