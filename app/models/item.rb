class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def self.search(search_params)
    where("name ILIKE ?", "%#{search_params}%")
    .order(name: :asc)
  end

  def self.find_by_max_price(max_filter)
    where('unit_price <= ?', max_filter)
    .order(name: :desc)
  end

  def self.find_by_min_price(min_filter)
    where('unit_price >=?', min_filter)
    .order(name: :asc)
  end

  def self.find_by_price_range(min_filter, max_filter)
    where("unit_price BETWEEN ? AND ?", "#{min_filter}", "#{max_filter}")
    .order(name: :asc)
  end
end
