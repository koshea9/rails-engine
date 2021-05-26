require 'rails_helper'

RSpec.describe 'Items API endpoint' do
  before :each do
    FactoryBot.reload
  end

  describe 'happy path' do
    it 'gets all items, a max of 20 at a time' do
      create_list(:merchant, 5)
      create_list(:item, 25)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq('item')

        expect(item).to have_key(:attributes)
        expect(item[:attributes][:name]).to be_an(String)
        expect(item[:attributes][:description]).to be_an(String)
        expect(item[:attributes][:unit_price]).to be_an(Float)
      end
    end

    it 'returns a subset of items based on user selected limit per page' do
      create_list(:merchant, 5)
      create_list(:item, 25)

      get '/api/v1/items?per_page=15'

      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].count).to eq(15)

      expect(items).to be_a(Hash)

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_an(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_an(String)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_an(String)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_an(Float)
      end
    end

    it 'returns the 2nd page of results with min 20 per page' do
      create_list(:merchant, 5)
      create_list(:item, 45)

      get '/api/v1/items?page=2'

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)

      expect(items[:data].first[:attributes][:name]).to eq('item-21')
      expect(items[:data].last[:attributes][:name]).to eq('item-40')

      expect(items).to be_a(Hash)

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_an(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_an(String)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_an(String)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_an(Float)
      end
    end

    it 'returns no item if user selects offset page that is too high' do
      create_list(:merchant, 5)
      create_list(:item, 45)

      get '/api/v1/items?page=90'

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(0)

      expect(items).to be_a(Hash)
    end

    it 'returns the first 20 items in the database for page 1' do
      create_list(:merchant, 5)
      create_list(:item, 25)

      get '/api/v1/items?page=1'

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)

      expect(items[:data].first[:attributes][:name]).to eq('item-1')
      expect(items[:data].last[:attributes][:name]).to eq('item-20')

      expect(items).to be_a(Hash)

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_an(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_an(String)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_an(String)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_an(Float)
      end
    end
  end

  describe 'sad path' do
    it 'defaults to return the first 20 items if user enters page 0' do
      create_list(:merchant, 5)
      create_list(:item, 25)

      get '/api/v1/items?page=0'

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)

      expect(items[:data].first[:attributes][:name]).to eq('item-1')
      expect(items[:data].last[:attributes][:name]).to eq('item-20')

      expect(items).to be_a(Hash)

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_an(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_an(String)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_an(String)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_an(Float)
      end
    end
  end
end
