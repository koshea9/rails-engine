require 'rails_helper'

RSpec.describe 'Single Item API endpoint' do
  before :each do
    FactoryBot.reload
    create_list(:item, 5)
  end

  describe 'happy path' do
    it 'returns a single item' do
      get '/api/v1/items/1'

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)
      expect(item.count).to eq(1)

      expect(item).to be_a(Hash)
      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to be_an(String)

      expect(item[:data]).to have_key(:type)
      expect(item[:data][:type]).to be_an(String)

      expect(item[:data]).to have_key(:attributes)
      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_an(String)
      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to be_an(String)
      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to be_an(Float)
    end
  end

  describe 'sad path' do
    it 'returns an error if item is not found' do
      get '/api/v1/items/789'

      expect(response).to_not be_successful

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:error)
      expect(error).to_not have_key(:data)
    end
  end

  describe 'edge case' do
  end
end
