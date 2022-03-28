require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    merchants = json[:data]
    expect(merchants.count).to eq(5)
    
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
end