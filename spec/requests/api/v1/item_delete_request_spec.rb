require 'rails_helper'

RSpec.describe 'Delete Item API Endpoint' do
  describe 'happy path' do
    it "deletes user selected item" do
      item = create(:item)

      expect(Item.count).to eq(1)

      expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

      expect(response).to be_successful
      expect(Item.count).to eq(0)
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'sad path' do
    it "returns an error if item selected to delete doesn't exist" do
      item = create(:item, id: 1)

      expect(Item.count).to eq(1)

      expect{ delete "/api/v1/items/2" }.to change(Item, :count).by(0)
      expect(response).to be_successful
      expect(Item.count).to eq(1)
      expect{Item.find(2)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'edge case' do
  end
end
