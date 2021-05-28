require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :status }
  end

  describe 'class methods' do
    before :each do
      FactoryBot.reload
    end

    describe '::unshipped_revenue_by_invoice' do
      it 'returns the total revenue for a user selected quantity of invoices' do
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

        expect(Invoice.unshipped_revenue_by_invoice(3)).to eq([invoice_7, invoice_3, invoice_5])
        expect(Invoice.unshipped_revenue_by_invoice(3).first.potential_revenue).to eq(100)
        expect(Invoice.unshipped_revenue_by_invoice(3).second.potential_revenue).to eq(60)
        expect(Invoice.unshipped_revenue_by_invoice(3).third.potential_revenue).to eq(50)
      end
    end
  end
end
