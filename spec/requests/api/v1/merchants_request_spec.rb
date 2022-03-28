require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    merchants = json[:data]
    expect(merchants.count).to eq(5)

    expect(merchants).to be_an(Array)
    
    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)

      attributes = merchant[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)
    end 
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id
  
    get "/api/v1/merchants/#{id}"
  
    json = JSON.parse(response.body, symbolize_names: true)

    merchant = json[:data]
  
    expect(response).to be_successful

    expect(merchant).to be_an(Hash)
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)

    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to be_a(String)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_a(Hash)

    attributes = merchant[:attributes]
    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    expect(merchant).to_not have_key(:items)
  end

  it 'get all items for a specific merchant' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = create_list(:item, 4, merchant_id: merchant_1.id)
    item_2 = create_list(:item, 5, merchant_id: merchant_2.id)
    get "/api/v1/merchants/#{merchant_1.id}/items"
    merchant_json = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_json).to be_an(Hash)
    expect(merchant_json[:data]).to be_an(Array)

    expect(merchant_json[:data].first).to have_key(:id)
    expect(merchant_json[:data].first[:id]).to be_an(String)

    expect(merchant_json[:data].first).to have_key(:type)
    expect(merchant_json[:data].first[:type]).to be_an(String)
    
    item = merchant_json[:data].first[:attributes]
    expect(item).to have_key(:name)
    expect(item).to have_key(:description)
    expect(item).to have_key(:unit_price)
    expect(item).to have_key(:merchant_id)
    expect(item[:merchant_id]).to eq(merchant_1.id)
    
    expect(item[:merchant_id]).to_not eq(merchant_2.id)
  end
end