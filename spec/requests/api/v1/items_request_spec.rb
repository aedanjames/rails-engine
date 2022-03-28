require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 10)

    get '/api/v1/items'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_an(Hash)

    items = json[:data]
    expect(items.count).to eq(10)
    
    expect(items).to be_an(Array)
    
    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
      
      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)
      
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)
      
      attributes = item[:attributes]
      
      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)
      
      expect(attributes).to have_key(:description)
      expect(attributes[:description]).to be_a(String)
      
      expect(attributes).to have_key(:unit_price)
      expect(attributes[:unit_price]).to be_a(Float)

      expect(attributes).to have_key(:merchant_id)
      expect(attributes[:merchant_id]).to be_a(Integer)
    end 
  end
end 