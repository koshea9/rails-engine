class Api::V1::Merchants::SearchController < ApplicationController
  def index
    evaluate_params
    render json: MerchantSerializer.new(evaluate_params)
  end
end

private

def evaluate_params
  if params[:name]
    return merchants = Merchant.search(params[:name])
  elsif params[:min_price] && params[:max_price]
    return merchants = Merchant.find_by_price_range(params[:min_price], params[:max_price])
  elsif params[:min_price]
    return merchants = Merchant.find_by_min_price(params[:min_price])
  elsif params[:max_price]
    return merchants = Merchant.find_by_max_price(params[:max_price])
  else
    return merchants = nil
  end
end
