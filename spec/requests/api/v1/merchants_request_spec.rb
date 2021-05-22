require 'rails_helper'

RSpec.describe 'Merchants API endpoint' do
  it 'returns a default max of 20 results if no per page limit applied in params' do
    create_list(:merchant, 60)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(20)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it 'returns a subset of merchants based on user selected limit per page' do
    create_list(:merchant, 60)

    get "/api/v1/merchants?per_page=15"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(15)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end
end
