require 'rails_helper'

RSpec.describe 'Single Merchant API endpoint' do
  before :each do
    FactoryBot.reload
    create_list(:merchant, 60)
  end

  describe 'happy path' do
    describe 'get single merchant' do
      it 'returns data for a single merchant' do
        get '/api/v1/merchants/1'

        expect(response).to be_successful

        merchant = JSON.parse(response.body, symbolize_names: true)
        expect(merchant.count).to eq(1)

        expect(merchant).to be_a(Hash)
        expect(merchant[:data]).to have_key(:id)
        expect(merchant[:data][:id]).to be_an(String)
        expect(merchant[:data]).to have_key(:type)
        expect(merchant[:data][:type]).to eq('merchant')
        expect(merchant[:data]).to have_key(:attributes)
        expect(merchant[:data][:attributes]).to have_key(:name)
        expect(merchant[:data][:attributes][:name]).to be_an(String)
      end
    end
  end

  describe 'sad path' do
    describe 'get single merchant' do
      it 'returns an error if merchant is not found' do
        get '/api/v1/merchants/999'

        expect(response).to_not be_successful

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:error)
        expect(error).to_not have_key(:data)

      end
    end
  end

  describe 'edge case' do
    describe 'get single merchant' do
    end
  end
end
