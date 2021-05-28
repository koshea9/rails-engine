require 'rails_helper'

RSpec.describe 'Total Revenue for Given Merchant' do
  before :each do
    FactoryBot.reload
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)
    merchant_5 = create(:merchant)
    invoice_1 = create(:shipped_invoice, merchant_id: merchant_2.id)
    invoice_2 = create(:shipped_invoice, merchant_id: merchant_1.id)
    invoice_3 = create(:not_shipped_invoice, merchant_id: merchant_3.id)
    invoice_4 = create(:shipped_invoice, merchant_id: merchant_4.id)
    invoice_5 = create(:shipped_invoice, merchant_id: merchant_5.id)
    invoice_6 = create(:shipped_invoice, merchant_id: merchant_4.id)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, quantity: 1, unit_price: 10)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, quantity: 5, unit_price: 10)
    invoice_item_3 = create(:invoice_item, invoice_id: invoice_3.id, quantity: 6, unit_price: 10)
    invoice_item_4 = create(:invoice_item, invoice_id: invoice_4.id, quantity: 2, unit_price: 10)
    invoice_item_5 = create(:invoice_item, invoice_id: invoice_5.id, quantity: 9, unit_price: 10)
    invoice_item_6 = create(:invoice_item, invoice_id: invoice_6.id, quantity: 10, unit_price: 10)
    transaction_1 = create(:successful_transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:successful_transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:successful_transaction, invoice_id: invoice_3.id)
    transaction_4 = create(:successful_transaction, invoice_id: invoice_4.id)
    transaction_5 = create(:unsuccessful_transaction, invoice_id: invoice_5.id)
    transaction_6 = create(:successful_transaction, invoice_id: invoice_6.id)
  end

  describe 'happy path' do
    it 'returns the total revenue for a single merchant' do
      get '/api/v1/revenue/merchants/1'
      
      expect(response).to be_successful

      merchant_revenue = JSON.parse(response.body, symbolize_names: true)

      expect(merchant_revenue.count).to eq(1)

      expect(merchant_revenue).to be_a(Hash)
      expect(merchant_revenue).to have_key(:data)
      expect(merchant_revenue[:data]).to be_a(Hash)
      expect(merchant_revenue[:data]).to have_key(:id)
      expect(merchant_revenue[:data][:id]).to be_a(String)
      expect(merchant_revenue[:data]).to have_key(:type)
      expect(merchant_revenue[:data][:type]).to be_a(String)
      expect(merchant_revenue[:data]).to have_key(:attributes)
      expect(merchant_revenue[:data][:attributes]).to be_a(Hash)
      expect(merchant_revenue[:data][:attributes]).to have_key(:revenue)
      expect(merchant_revenue[:data][:attributes][:revenue]).to be_a(Float)
    end
  end

  describe 'sad path' do
  end

  describe 'edge case' do
  end
end
