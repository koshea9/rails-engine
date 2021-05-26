class MerchantSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name
  attribute :revenue, if: proc { |record, params|
      params[:quantity] == true
    } do |object|
      object.total_revenue
    end
  end
