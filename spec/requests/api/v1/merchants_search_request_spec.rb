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

  it "can find all merchants from a partial case-insensitive search" do
    merchant_1 = Merchant.create!(name: "The Duke")
    merchant_2 = Merchant.create!(name: "The Stranger")
    merchant_3 = Merchant.create!(name: "The Strangest")
  
    get "/api/v1/merchants/find_all?name=Strange"
    
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(200)
    merchants_array = merchants[:data]
    
    expect(merchants_array).to be_an(Array)
    expect(merchants_array.count).to eq(2)
    expect(merchants_array.first).to have_key(:id)
    expect(merchants_array.first[:id]).to eq("#{merchant_2.id}")
    expect(merchants_array.first).to have_key(:type)
    expect(merchants_array.last[:id]).to eq("#{merchant_3.id}")
    expect(merchants_array.first).to have_key(:attributes)
    attributes_1 = merchants_array.first[:attributes]
    expect(attributes_1).to have_key(:name)
    expect(attributes_1[:name]).to be_an(String)
    expect(attributes_1[:name]).to eq("#{merchant_2.name}")
    expect(attributes_1[:name]).to_not eq("#{merchant_1.name}")

    attributes_2 = merchants_array.last[:attributes]
    expect(attributes_2).to have_key(:name)
    expect(attributes_2[:name]).to be_an(String)
    expect(attributes_2[:name]).to eq("#{merchant_3.name}")
    expect(attributes_1[:name]).to_not eq("#{merchant_1.name}")
  end 
end 