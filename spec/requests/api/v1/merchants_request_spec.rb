require 'rails_helper'

RSpec.describe 'Merchants API endpoint' do
  before :each do
    FactoryBot.reload
    create_list(:merchant, 60)
  end

  describe "happy path" do
  it 'returns a default max of 20 results if no per page limit applied in params' do
    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(20)

    expect(merchants).to be_a(Hash)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it 'returns a subset of merchants based on user selected limit per page' do
    get "/api/v1/merchants?per_page=15"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(15)

    expect(merchants).to be_a(Hash)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it 'returns a subset of merchants larger than default based on user selected limit per page' do
    get "/api/v1/merchants?per_page=50"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(50)

    expect(merchants).to be_a(Hash)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it 'returns the 2nd page of results with min 20 per page - starts with Merchant 21' do
    get "/api/v1/merchants?page=2"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(20)

    expect(merchants[:data].first[:attributes][:name]).to eq("merchant-21")
    expect(merchants[:data].last[:attributes][:name]).to eq("merchant-40")

    expect(merchants).to be_a(Hash)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it 'returns no merchant if user selects offset page that is too high' do
    get "/api/v1/merchants?page=60"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(0)

    expect(merchants).to be_a(Hash)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it "returns the first 20 merchants in the database for page 1" do
    get "/api/v1/merchants?page=1"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(20)
    expect(merchants[:data].first[:attributes][:name]).to eq("merchant-1")
    expect(merchants[:data].last[:attributes][:name]).to eq("merchant-20")

    expect(merchants).to be_a(Hash)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end
end

  describe "sad path" do
    it "returns defaults to return the first 20 merchants if user enters page 0" do
      get "/api/v1/merchants?page=-1"

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(20)
      expect(merchants[:data].first[:attributes][:name]).to eq("merchant-1")
      expect(merchants[:data].last[:attributes][:name]).to eq("merchant-20")

      expect(merchants).to be_a(Hash)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_an(String)
      end
    end
end

  describe "edge case" do
    it "returns defaults to return the first 20 merchants if user enters page less than 1" do
      get "/api/v1/merchants?page=-1"

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(20)
      expect(merchants[:data].first[:attributes][:name]).to eq("merchant-1")
      expect(merchants[:data].last[:attributes][:name]).to eq("merchant-20")

      expect(merchants).to be_a(Hash)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_an(String)
      end
    end
  end
end
