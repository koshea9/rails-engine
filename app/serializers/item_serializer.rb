class ItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :description, :unit_price
  attribute :merchant_id, if: Proc.new { |record, params|
    params[:merchant_item] == true
   }
end
