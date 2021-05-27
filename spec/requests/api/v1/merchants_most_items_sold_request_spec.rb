require 'rails_helper'

RSpec.describe 'Merchants most items sold API endpoint' do
  before :each do
  end

  describe 'happy path' do
    it 'returns a variable number of merchants ranked by total items sold' do
      get "/api/v1/merchants/most_items?quantity=3"

      expect(response).to be_successful

      merchants_items = JSON.parse(response.body, symbolize_names: true)

      expect(merchants_items[:data].count).to eq(3)

      expect(merchants_items).to be_a(Hash)
      merchants_items[:data].each do |merchant_item|
        expect(merchant_item).to have_key(:id)
        expect(merchant_item[:id]).to be_an(String)

        expect(merchant_item).to have_key(:type)
        expect(merchant_item[:type]).to be_an(String)

        expect(merchant_item).to have_key(:attributes)
        expect(merchant_item[:attributes]).to be_an(Hash)

        expect(merchant_item[:attributes]).to have_key(:name)
        expect(merchant_item[:attributes][:name]).to be_an(String)

        expect(merchant_item[:attributes]).to have_key(:count)
        expect(merchant_item[:attributes][:count]).to be_an(Float)
      end
    end
  end

  describe 'sad path' do
  end

  describe 'edge cases' do
  end
end
