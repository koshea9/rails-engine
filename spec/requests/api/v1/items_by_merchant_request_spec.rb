require 'rails_helper'

RSpec.describe 'Items by Merchant API endpoint' do
  before :each do
    FactoryBot.reload
  end

  describe "happy path" do
    it 'returns all items for a given merchant' do
      merchant_1 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_1.id)
      item_3 = create(:item, merchant_id: merchant_1.id)
      item_4 = create(:item, merchant_id: merchant_1.id)
      item_5 = create(:item, merchant_id: merchant_1.id)
      item_6 = create(:item, merchant_id: merchant_1.id)
      item_7 = create(:item, merchant_id: merchant_1.id)

      get '/api/v1/merchants/1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(7)
      expect(items[:data].first[:attributes][:name]).to eq(item_1.name)

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq('item')

        expect(item).to have_key(:attributes)
        expect(item[:attributes][:name]).to be_an(String)
        expect(item[:attributes][:description]).to be_an(String)
        expect(item[:attributes][:unit_price]).to be_an(Float)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end
  end

  describe "sad path" do
    it "returns error message if no items returned" do
      merchant_no_items = create(:merchant)

      get '/api/v1/merchants/99999/items'

      expect(response).to_not be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:error]).to be_a(String)
      expect(items[:data]).to have_key(:id)
      expect(items[:data][:id]).to eq(nil)
      expect(items[:data]).to have_key(:attributes)
      expect(items[:data][:attributes][:name]).to be_empty
      expect(items[:data][:attributes][:description]).to be_empty
      expect(items[:data][:attributes][:unit_price]).to be_empty

    end
  end

  describe "edge case" do
  end
end
