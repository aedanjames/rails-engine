require 'rails_helper'

describe 'Items Search API Endpoints' do
  it 'can find all items from a partial case-insensitive search' do 
    hat = create(:item, name: "Hat")
    jacket = create(:item, name: "Jacket")
    treat = create(:item, name: "Dog treat")

    get '/api/v1/items/find_all?name=At'

    expect(response).to be_successful

    at_search = JSON.parse(response.body, symbolize_names: true)
    expect(at_search).to be_an(Hash)
    expect(at_search).to have_key(:data)
    
    data = at_search[:data]
    expect(data.count).to eq(2)

    expect(data).to be_an(Array)
    expect(data.first).to have_key(:id)
    expect(data.first[:id]).to eq("#{hat.id}")
    expect(data.last[:id]).to eq("#{treat.id}")
    
    expect(data[0].values.include?("#{jacket.id}")).to eq(false)
    expect(data[1].values.include?("#{jacket.id}")).to eq(false)

    expect(data.first).to have_key(:type)
    expect(data.first[:type]).to be_an(String)
    
    expect(data.first).to have_key(:attributes)
    attributes = data.first[:attributes]
    expect(attributes).to be_an(Hash)

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_an(String)

    expect(attributes).to have_key(:description)
    expect(attributes[:description]).to be_an(String)

    expect(attributes).to have_key(:unit_price)
    expect(attributes[:unit_price]).to be_an(Float)

    expect(attributes).to have_key(:merchant_id)
    expect(attributes[:merchant_id]).to be_an(Integer)
  end
end