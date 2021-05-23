class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all.limit(page_limit).offset(page)
    render json: MerchantSerializer.new(merchants)
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
      ( params[:page].to_i - 1 ) * page_limit
    end
  end
end
