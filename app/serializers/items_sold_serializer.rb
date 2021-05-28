class ItemsSoldSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name
  attribute :count, &:items_sold_count
end
