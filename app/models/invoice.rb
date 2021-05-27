class Invoice < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: { 'shipped' => 0, 'returned' => 1, 'packaged' => 2 }

  def self.unshipped_revenue_by_invoice(invoice_limit)
    joins(:invoice_items)
    .where.not(status: "shipped")
    .select("invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS potential_revenue")
    .group(:id)
    .order("potential_revenue DESC")
    .limit(invoice_limit)
  end
end
