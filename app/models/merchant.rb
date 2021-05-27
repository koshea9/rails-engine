class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  validates :name, presence: true

  def self.total_revenue_ranking(merchant_limit)
    joins(invoice_items: {invoice: :transactions})
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .group(:id)
    .where(transactions: {result: "success"}, invoices: {status: "shipped"})
    .order("revenue DESC")
    .limit(merchant_limit)
  end

  def self.rank_by_items_sold(merchant_limit)
    joins(items: :invoice_items)
    .select("merchants.*, COUNT(items.id) as items_sold_count")
    .group(:id)
    .order("items_sold_count DESC")
    .limit(merchant_limit)
  end

  def total_revenue
    invoice_items.joins(invoice: :transactions)
    .where(transactions: {result: "success"}, invoices: {status: "shipped"})
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
