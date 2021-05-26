class Api::V1::ItemsController < ApplicationController

  def index
    if params[:merchant_id]
      merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.new(merchant.items, { params: { merchant_item: true } })
    else
      render json: ItemSerializer.new(Item.first(20))
    end
  end
end
