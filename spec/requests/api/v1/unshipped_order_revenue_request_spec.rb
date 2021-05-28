require 'rails_helper'

RSpec.describe 'Unshipped Order Revenue Request' do
  before :each do
    FactoryBot.reload

    invoice_1 = create(:shipped_invoice)
    invoice_2 = create(:shipped_invoice)
    invoice_3 = create(:not_shipped_invoice)
    invoice_4 = create(:shipped_invoice)
    invoice_5 = create(:not_shipped_invoice)
    invoice_6 = create(:shipped_invoice)
    invoice_7 = create(:not_shipped_invoice)

    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, quantity: 1, unit_price: 10)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, quantity: 5, unit_price: 10)
    invoice_item_3 = create(:invoice_item, invoice_id: invoice_3.id, quantity: 6, unit_price: 10)
    invoice_item_4 = create(:invoice_item, invoice_id: invoice_4.id, quantity: 2, unit_price: 10)
    invoice_item_5 = create(:invoice_item, invoice_id: invoice_5.id, quantity: 5, unit_price: 10)
    invoice_item_6 = create(:invoice_item, invoice_id: invoice_6.id, quantity: 10, unit_price: 10)
    invoice_item_7 = create(:invoice_item, invoice_id: invoice_7.id, quantity: 10, unit_price: 10)

    transaction_1 = create(:successful_transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:successful_transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:successful_transaction, invoice_id: invoice_3.id)
    transaction_4 = create(:successful_transaction, invoice_id: invoice_4.id)
    transaction_5 = create(:successful_transaction, invoice_id: invoice_5.id)
    transaction_6 = create(:successful_transaction, invoice_id: invoice_6.id)
    transaction_7 = create(:successful_transaction, invoice_id: invoice_7.id)
  end

  describe 'happy path' do
    it 'returns the total revenue for unshipped orders with quanitity limit' do
      get '/api/v1/revenue/unshipped?quantity=2'

      expect(response).to be_successful

      unshipped_revenue = JSON.parse(response.body, symbolize_names: true)

      expect(unshipped_revenue[:data].count).to eq(2)
      expect(unshipped_revenue).to be_a(Hash)

      unshipped_revenue[:data].each do |invoice|
        expect(invoice).to have_key(:id)
        expect(invoice[:id]).to be_a(String)
        expect(invoice).to have_key(:type)
        expect(invoice[:type]).to be_a(String)
        expect(invoice).to have_key(:attributes)
        expect(invoice[:attributes]).to be_a(Hash)
        expect(invoice[:attributes]).to have_key(:potential_revenue)
        expect(invoice[:attributes][:potential_revenue]).to be_a(Float)
      end
    end
  end

  describe 'sad path' do
  end

  describe 'edge cases' do
  end
end
