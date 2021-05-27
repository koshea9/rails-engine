require 'rails_helper'

RSpec.describe 'Create Item API Endpoint' do
  describe 'happy path' do
    it 'can create a new item' do
      item_params = ({
        name: 'hot dish displayer',
        description: 'show off your hot dish at the next picnic',
        unit_price: 65.99,
        merchant_id: 87
      })

      headers = { "CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
      created_item = Item.last

      expect(response).to be_successful
      expect(created_item.name).to eq(items_params[:name])
      expect(created_item.description).to eq(items_params[:description])
      expect(created_item.unit_price).to eq(items_params[:unit_price])
      expect(created_item.merchant_id).to eq(items_params[:merchant_id])
    end
  end

  describe 'sad path' do
  end

  describe 'edge cases' do
  end
end
