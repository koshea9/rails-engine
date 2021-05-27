require 'rails_helper'

RSpec.describe "Item update API request" do
  describe "happy path" do
    it "can update an existing item" do
      id = create(:item).id
      previous_name = Item.last.name
      item_params = { name: "New Improved Name" }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("New Improved Name")
    end
  end

  describe "sad path" do
  end

  describe "edge case" do
  end
end
