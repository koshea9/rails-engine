class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :revenue do |object|
      object.total_revenue
    end
  end
