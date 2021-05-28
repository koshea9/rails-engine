class Api::V1::Items::SearchController < ApplicationController
  def show
    if params[:name]
      item = Item.search(params[:name]).first
      render json: ItemSerializer.new(item)
    elsif params[:min_price] && params[:max_price]
      item = Item.find_by_price_range(params[:min_price], params[:max_price])
      render json: ItemSerializer.new(item)
    elsif params[:min_price]
      item = Item.find_by_min_price(params[:min_price]).first
      render json: ItemSerializer.new(item)
    elsif params[:max_price]
      item = Item.find_by_max_price(params[:max_price]).first
      render json: ItemSerializer.new(item)
    else
      render json: {status: "error", code: 400}
    end
  end
end
