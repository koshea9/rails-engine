require 'rails_helper'

RSpec.describe 'Find Item API Endpoint' do
  describe 'happy path' do
    it 'finds a single item that matches the name search query' do
      item_1 = create(:item, name: 'Blue Topaz Ring')
      item_2 = create(:item, name: 'Another color ring')
      get '/api/v1/items/find?name=ring'

      expect(response).to be_successful

      item_result = JSON.parse(response.body, symbolize_names: true)
      expect(item_result.count).to eq(1)
      expect(item_result[:data][:attributes][:name]).to eq(item_2.name)

      expect(item_result[:data]).to have_key(:id)
      expect(item_result[:data][:id]).to be_an(String)

      expect(item_result[:data]).to have_key(:type)
      expect(item_result[:data][:type]).to eq('item')

      expect(item_result[:data]).to have_key(:attributes)
      expect(item_result[:data][:attributes][:name]).to be_an(String)
      expect(item_result[:data][:attributes][:description]).to be_an(String)
      expect(item_result[:data][:attributes][:unit_price]).to be_an(Float)
      expect(item_result[:data][:attributes][:merchant_id]).to be_an(Integer)
    end

    it 'finds a single item that matches the max price search query' do
      cheaper_item = create(:item, unit_price: 40)
      expensive_item = create(:item, unit_price: 60)
      get '/api/v1/items/find?max_price=50'

      expect(response).to be_successful

      item_result = JSON.parse(response.body, symbolize_names: true)
      expect(item_result.count).to eq(1)
      expect(item_result[:data][:attributes][:unit_price]).to eq(cheaper_item.unit_price)

      expect(item_result[:data]).to have_key(:id)
      expect(item_result[:data][:id]).to be_an(String)

      expect(item_result[:data]).to have_key(:type)
      expect(item_result[:data][:type]).to eq('item')

      expect(item_result[:data]).to have_key(:attributes)
      expect(item_result[:data][:attributes][:name]).to be_an(String)
      expect(item_result[:data][:attributes][:description]).to be_an(String)
      expect(item_result[:data][:attributes][:unit_price]).to be_an(Float)
      expect(item_result[:data][:attributes][:merchant_id]).to be_an(Integer)
    end

    it 'finds a single item that matches the min price search query' do
      cheaper_item = create(:item, unit_price: 40)
      expensive_item = create(:item, unit_price: 60)
      get '/api/v1/items/find?min_price=50'

      expect(response).to be_successful

      item_result = JSON.parse(response.body, symbolize_names: true)
      expect(item_result.count).to eq(1)
      expect(item_result[:data][:attributes][:unit_price]).to eq(expensive_item.unit_price)

      expect(item_result[:data]).to have_key(:id)
      expect(item_result[:data][:id]).to be_an(String)

      expect(item_result[:data]).to have_key(:type)
      expect(item_result[:data][:type]).to eq('item')

      expect(item_result[:data]).to have_key(:attributes)
      expect(item_result[:data][:attributes][:name]).to be_an(String)
      expect(item_result[:data][:attributes][:description]).to be_an(String)
      expect(item_result[:data][:attributes][:unit_price]).to be_an(Float)
      expect(item_result[:data][:attributes][:merchant_id]).to be_an(Integer)
    end

    it 'finds a single item that matches the range price search query' do
      cheaper_item = create(:item, unit_price: 40)
      range_item = create(:item, unit_price: 55)
      expensive_item = create(:item, unit_price: 70)
      get '/api/v1/items/find?min_price=50&max_price=60'

      expect(response).to be_successful

      item_result = JSON.parse(response.body, symbolize_names: true)
      expect(item_result.count).to eq(1)
      expect(item_result[:data][:attributes][:unit_price]).to eq(range_item.unit_price)

      expect(item_result[:data]).to have_key(:id)
      expect(item_result[:data][:id]).to be_an(String)

      expect(item_result[:data]).to have_key(:type)
      expect(item_result[:data][:type]).to eq('item')

      expect(item_result[:data]).to have_key(:attributes)
      expect(item_result[:data][:attributes][:name]).to be_an(String)
      expect(item_result[:data][:attributes][:description]).to be_an(String)
      expect(item_result[:data][:attributes][:unit_price]).to be_an(Float)
      expect(item_result[:data][:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  describe 'sad path' do
    it 'finds a single item that matches the range price search query' do
      cheaper_item = create(:item, unit_price: 40)
      range_item = create(:item, unit_price: 55)
      expensive_item = create(:item, unit_price: 70)
      get '/api/v1/items/find?min_price=50&max_price=60'

      expect(response).to be_successful

      item_result = JSON.parse(response.body, symbolize_names: true)
      expect(item_result.count).to eq(1)
      expect(item_result[:data][:attributes][:unit_price]).to eq(range_item.unit_price)

      expect(item_result[:data]).to have_key(:id)
      expect(item_result[:data][:id]).to be_an(String)

      expect(item_result[:data]).to have_key(:type)
      expect(item_result[:data][:type]).to eq('item')

      expect(item_result[:data]).to have_key(:attributes)
      expect(item_result[:data][:attributes][:name]).to be_an(String)
      expect(item_result[:data][:attributes][:description]).to be_an(String)
      expect(item_result[:data][:attributes][:unit_price]).to be_an(Float)
      expect(item_result[:data][:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  describe 'edge case' do
  end
end
