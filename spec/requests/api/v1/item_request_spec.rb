require 'rails_helper'

RSpec.describe 'Single Item API endpoint' do
  before :each do
    create_list(:item, 5)
  end

  describe 'happy path' do
    it 'returns a single item' do
      get '/api/v1/items/1'
    end
  end

  describe 'sad path' do
  end

  describe 'edge case' do
  end
end
