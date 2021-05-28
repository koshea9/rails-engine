class Api::V1::Merchants::SearchController < ApplicationController
  def index
    render json: MerchantSerializer.new(evaluate_params)
  end
end

private

def evaluate_params
  merchants = if params[:name]
                Merchant.search(params[:name])
              elsif params[:min_price] && params[:max_price]
                Merchant.find_by_price_range(params[:min_price], params[:max_price])
              elsif params[:min_price]
                Merchant.find_by_min_price(params[:min_price])
              elsif params[:max_price]
                Merchant.find_by_max_price(params[:max_price])
              end
end
