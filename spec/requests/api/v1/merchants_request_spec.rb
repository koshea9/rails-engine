require "rails_helper"

describe "Merchants API endpoint" do
  it "gets all merchants, a max of 20 at a time" do
    create_list(:merchant, 60)

    get "/api/v1/merchants"

    expect(response).to be_successful
  end
end
