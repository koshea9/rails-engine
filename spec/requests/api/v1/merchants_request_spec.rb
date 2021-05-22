require "rails_helper"

RSpec.describe "Merchants API endpoint" do
  it "gets all merchants, a max of 20 at a time" do
    create_list(:merchant, 60)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)

      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_an(String)
    end
  end
end
