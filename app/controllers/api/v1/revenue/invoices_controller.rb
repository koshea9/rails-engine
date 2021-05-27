class Api::V1::Revenue::InvoicesController < ApplicationController
  def index
    invoices = Invoice.unshipped_revenue_by_invoice(params[:quantity])
    render json: UnshippedOrderSerializer.new(invoices)
  end
end
