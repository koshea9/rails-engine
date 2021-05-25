require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many :items }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'class methods' do
    describe '::total_revenue_ranking(merchant_limit)' do
      it 'returns a variable number of merchants ranked by total revenue' do
        #merchants
        # 10 revenue
        merchant_1 = create(:merchant)
        # 50 revenue
        merchant_2 = create(:merchant)
        # not eligible 60 revenue
        merchant_3 = create(:merchant)
        # 120 revenue
        merchant_4 = create(:merchant)
        # not eligible 90 revenue
        merchant_5 = create(:merchant)

        #invoices -'shipped' to count towards revenue
        #10
        invoice_1 = create(:shipped_invoice, merchant_id: merchant_2.id)
        #50
        invoice_2 = create(:shipped_invoice, merchant_id: merchant_1.id)
        #no eligible 60
        invoice_3 = create(:not_shipped_invoice, merchant_id: merchant_3.id)
        #20
        invoice_4 = create(:shipped_invoice, merchant_id: merchant_4.id)
        #90
        invoice_5 = create(:shipped_invoice, merchant_id: merchant_5.id)
        #100 merchant 4
        invoice_6 = create(:shipped_invoice, merchant_id: merchant_4.id)

        #invoice_items
        invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, quantity: 1, unit_price: 10)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, quantity: 5, unit_price: 10)
        invoice_item_3 = create(:invoice_item, invoice_id: invoice_3.id, quantity: 6, unit_price: 10)
        invoice_item_4 = create(:invoice_item, invoice_id: invoice_4.id, quantity: 2, unit_price: 10)
        invoice_item_5 = create(:invoice_item, invoice_id: invoice_5.id, quantity: 9, unit_price: 10)
        invoice_item_6 = create(:invoice_item, invoice_id: invoice_6.id, quantity: 10, unit_price: 10)

        #transaction -'success' to count towards revenue
        transaction_1 = create(:successful_transaction, invoice_id: invoice_1.id)
        transaction_2 = create(:successful_transaction, invoice_id: invoice_2.id)
        transaction_3 = create(:successful_transaction, invoice_id: invoice_3.id)
        transaction_4 = create(:successful_transaction, invoice_id: invoice_4.id)
        transaction_5 = create(:unsuccessful_transaction, invoice_id: invoice_5.id)
        transaction_6 = create(:successful_transaction, invoice_id: invoice_6.id)

        expect(Merchant.total_revenue_ranking(2)).to eq([merchant_4, merchant_1])
        expect(Merchant.total_revenue_ranking(2).first.revenue).to eq(120)
        expect(Merchant.total_revenue_ranking(2).second.revenue).to eq(50)
      end
    end
  end
end
