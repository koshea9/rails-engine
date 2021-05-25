class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.total_revenue_ranking(merchant_limit)
    joins(invoices: :invoice_items)
    .joins(:transactions)
    .where(transactions: {result: "success"}, invoices: {status: "shipped"})
    .select("merchants.*, SUM(DISTINCT invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .group(:id)
    .order("revenue DESC")
    .limit(merchant_limit)
  end
end
