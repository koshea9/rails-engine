class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

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
