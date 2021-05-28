class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity].blank? || !params[:quantity].class == Integer
      render json: {status: 404, message: "Please enter quantity as an integer"}
    else
      merchants = Merchant.total_revenue_ranking(params[:quantity])
      render json: MerchantNameRevenueSerializer.new(merchants)
    end
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantRevenueSerializer.new(merchant)
  end
end
