class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity].blank? || !params[:quantity].class == Integer
      render json: {status: "error", code: 400, message: "Please enter quantity as an integer"}
    else
    merchants = Merchant.total_revenue_ranking(params[:quantity])
    render json: MerchantSerializer.new(merchants, { params: { quantity: true } })
    end
  end
  private
end
