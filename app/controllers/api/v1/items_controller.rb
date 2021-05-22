class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.first(20))
  end
end
