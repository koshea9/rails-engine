class Api::V1::ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:merchant_id]
      merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.new(merchant.items, {params: {merchant_item: true}})
    else
      render json: ItemSerializer.new(Item.first(20))
    end
  end

  private
  def render_not_found_response(exception)
    render json: {
      error: exception.message,
      "data":
        {
      "id": nil,
        "type": "item",
        "attributes": {
          "name": "",
          "description": "",
          "unit_price": ""
        }}
      },
      status: :not_found
  end
end
