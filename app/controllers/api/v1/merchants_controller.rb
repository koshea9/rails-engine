class Api::V1::MerchantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:item_id]
      item = Item.find(params[:item_id])
      merchant = Merchant.find(item.merchant_id)
      render json: MerchantSerializer.new(merchant)
    else
      merchants = Merchant.all.limit(page_limit).offset(page)
      render json: MerchantSerializer.new(merchants)
    end
  end

  def show
    if params[:id] == "most_items"
      merchants = Merchant.rank_by_items_sold(params[:quantity])
      render json: ItemsSoldSerializer.new(merchants)
    else
      merchant = Merchant.find(params[:id])
      render json: MerchantSerializer.new(merchant)
    end
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
