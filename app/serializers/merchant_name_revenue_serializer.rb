class MerchantNameRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :name
  attribute :revenue do |object|
    object.total_revenue
  end
end
