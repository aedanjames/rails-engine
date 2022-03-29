require 'rails_helper'

describe "Merchants Search API" do
  it "can find a merchant from a partial case-insensitive search" do
    merchant_1 = Merchant.create!(name: "The Duke")
    merchant_2 = Merchant.create!(name: "The Stranger")
    merchant_3 = Merchant.create!(name: "The Strangest")
  
    get "/api/v1/merchants/find?name=Strange"
  
    merchant = JSON.parse(response.body, symbolize_names: true)
    response_data = merchant[:data][:attributes][:name]
  
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response_data).to eq(merchant_2.name)
    expect(response_data).to_not eq(merchant_1.name)
    expect(response_data).to_not eq(merchant_3.name)

    expect(merchant).to be_an(Hash)
    expect(merchant[:data]).to be_an(Hash)
    data = merchant[:data]

    expect(data).to have_key(:id)
    expect(data[:id].to_s).to eq("#{merchant_2.id}")
    expect(data[:attributes]).to have_key(:name)
    expect(data[:attributes][:name]).to eq(merchant_2.name)
    expect(data).to have_key(:type)
    expect(data[:type]).to be_an(String)
  end 
end 