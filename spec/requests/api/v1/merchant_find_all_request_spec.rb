require 'rails_helper'

RSpec.describe 'Find All Merchants API endpoint' do
  describe 'happy path' do
    it 'returns all merchants that match search result' do
      merchant_1 = create(:merchant, name: "Turing School")
      merchant_2 = create(:merchant, name: "Ring World")
      merchant_3 = create(:merchant, name: "Square World")

      get '/api/v1/merchants/find_all?name=ring'
      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants[:data].count).to eq(2)
      expect(merchants[:data].first[:attributes][:name]).to eq(merchant_2.name)
      expect(merchants[:data].second[:attributes][:name]).to eq(merchant_1.name)

      expect(merchants).to be_a(Hash)
      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_an(String)

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_an(Hash)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_an(String)
      end
    end
  end

  describe 'sad path' do
  end

  describe 'edge case' do
  end
end
