class Api::V1::MerchantsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


  def index
    merchants = Merchant.all.limit(page_limit).offset(page)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  end

  private
  def render_not_found_response(exception)
    render json: {
      error: exception.message,
      "data":
        {
      "id": nil,
        "type": "merchant",
        "attributes": {
          "name": "",
        }}
      },
      status: :not_found
  end

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
      ( params[:page].to_i - 1 ) * page_limit
    end
  end
end
