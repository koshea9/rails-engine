class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.limit(page_limit).offset(params[:page])
    render json: MerchantSerializer.new(merchants)
  end

  private

  def page_limit
    [
      params.fetch(:per_page, 20).to_i,
      20
    ].min
  end
end
