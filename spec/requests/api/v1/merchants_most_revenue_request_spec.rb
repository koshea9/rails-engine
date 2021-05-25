require 'rails_helper'

RSpec.describe 'Merchants most revenue API endpoint' do
  before :each do
    FactoryBot.reload
    create_list(:merchant, 60)
  end

  describe 'happy path' do
    it 'returns a variable number of merchants ranked by total revenue' do
      get '/api/v1/revenue/merchants?quantity=2'

      expect(response).to be_successful

      merchants_by_revenue = JSON.parse(response.body, symbolize_names: true)

      expect(merchants_by_revenue[:data].count).to eq(2)

      expect(merchants_by_revenue).to be_a(Hash)
      merchants_by_revenue[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_an(String)

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_an(Hash)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_an(String)

        expect(merchant[:attributes]).to have_key(:revenue)
        expect(merchant[:attributes][:revenue]).to be_an(Float)
      end
    end
  end

  describe 'sad path' do
  end

  describe 'edge cases' do
  end
end
