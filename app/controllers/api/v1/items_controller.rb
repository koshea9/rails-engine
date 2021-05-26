class Api::V1::ItemsController < ApplicationController

  def index
    if params[:merchant_id]
      merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.new(merchant.items, { params: { merchant_item: true } })
    else
      items = Item.all.limit(page_limit).offset(page)
      render json: ItemSerializer.new(items)
    end
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  private

  def page_limit
    if params[:per_page].nil? || params[:per_page].to_i < 0
      20
    else
      params[:per_page].to_i
    end
  end

  def page
    if params[:page].nil? || params[:page].to_i < 1
      0
    else
      (params[:page].to_i - 1) * page_limit
    end
  end
end
