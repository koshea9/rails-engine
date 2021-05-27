require 'rails_helper'

RSpec.describe 'Find Item API Endpoint' do
  describe 'happy path' do
    it 'finds a single item that matches the search query' do
      ring = create(:item, name: "Blue Topaz Ring")
      get '/api/v1/items/find?name=ring' do

        expect(response).to be_successful
    end
  end

  describe 'sad path' do
  end

  describe 'edge case' do
  end
end
