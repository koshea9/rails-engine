require 'rails_helper'

RSpec.describe "Items API endpoint" do
  it "gets all items, a max of 20 at a time" do
    create_list(:item, 60)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(20)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq("item")

      expect(item).to have_key(:attributes)
      expect(item[:attributes][:name]).to be_an(String)
      expect(item[:attributes][:description]).to be_an(String)
      expect(item[:attributes][:unit_price]).to be_an(Float)
    end

  end
end
