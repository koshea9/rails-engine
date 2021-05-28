class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(evaluate_params)
  end
  
  private

  def evaluate_params
    if params[:name]
      return item = Item.search(params[:name]).first
    elsif params[:min_price] && params[:max_price]
      return item = Item.find_by_price_range(params[:min_price], params[:max_price]).first
    elsif params[:min_price]
      return item = Item.find_by_min_price(params[:min_price]).first
    elsif params[:max_price]
      return item = Item.find_by_max_price(params[:max_price]).first
    else
      return item = nil
    end
  end
end
