require 'rails_helper'

RSpec.describe 'Merchant by Item API endpoint' do
  before :each do
    FactoryBot.reload
  end

  describe 'happy path' do
    it 'returns the merchant associated with a given item' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_2.id)

      get '/api/v1/items/1/merchant'

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data.count).to eq(1)
      expect(data[:data][:attributes][:name]).to eq(merchant_1.name)
    end
  end

  describe 'sad path' do
  end

  describe 'edge case' do
  end
end
