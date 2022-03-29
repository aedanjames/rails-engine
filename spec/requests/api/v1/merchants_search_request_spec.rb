require 'rails_helper'

describe "Merchants Search API" do
  it "can find a merchant from a partial case-insensitive search" do

    it 'find one merchant based on a search by name' do
      merchant_1 = Merchant.create!(name: "The Duke")
      merchant_2 = Merchant.create!(name: "The Stranger")
    
      get "/api/v1/merchants/find?name=Stranger"
    
      merchant = JSON.parse(response.body, symbolize_names: true)
      response_data = merchant[:data][:attributes][:name]
    
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response_data).to eq(merchant_1.name)
    end
  end 
end 