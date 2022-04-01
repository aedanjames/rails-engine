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

  it 'returns a hash with a data key and empty array value if find_all search yields no results' do 
    hat = create(:item, name: "Hat")
    jacket = create(:item, name: "Jacket")
    treat = create(:item, name: "Dog treat")

    get '/api/v1/items/find_all?name=ron'
    expect(response).to be_successful

    search = JSON.parse(response.body, symbolize_names: true)
    expect(search).to be_an(Hash)
    expect(search).to have_key(:data)
    expect(search[:data]).to be_an(Array)
    expect(search[:data].empty?).to eq(true)
  end

  it 'returns a hash with a data key and error message value if find search yields no results' do 
    hat = create(:item, name: "Hat")
    jacket = create(:item, name: "Jacket")
    treat = create(:item, name: "Dog treat")

    get '/api/v1/items/find?name=ron'
    expect(response).to be_successful
    
    search = JSON.parse(response.body, symbolize_names: true)
    expect(search).to be_an(Hash)
    expect(search).to have_key(:data)

    expect(search[:data]).to be_an(Hash)
    expect(search[:data][:message]).to be_an(String)
  end

  it 'returns status code 400 if no find_all search query is provided' do 
    hat = create(:item, name: "Hat")
    jacket = create(:item, name: "Jacket")
    treat = create(:item, name: "Dog treat")

    get '/api/v1/items/find_all?name='
    expect(response.status).to eq(400)
  end

  it 'returns status code 400 if no find search query is provided' do 
    hat = create(:item, name: "Hat")
    jacket = create(:item, name: "Jacket")
    treat = create(:item, name: "Dog treat")

    get '/api/v1/items/find?name='
    expect(response.status).to eq(400)
  end

  it 'returns status code 400 if no search query is provided' do 
    hat = create(:item, name: "Hat")
    jacket = create(:item, name: "Jacket")
    treat = create(:item, name: "Dog treat")

    get '/api/v1/items/find_all?name='
    expect(response.status).to eq(400)
  end

  it 'can find one item from a partial case-insensitive search' do 
    hat = create(:item, name: "Hat")
    jacket = create(:item, name: "Jacket")
    treat = create(:item, name: "Dog treat")

    get '/api/v1/items/find?name=At'

    expect(response).to be_successful

    at_search = JSON.parse(response.body, symbolize_names: true)
    expect(at_search).to be_an(Hash)
    expect(at_search.count).to eq(1)
    expect(at_search[:data]).to be_an(Hash)
    
    expect(at_search[:data][:id]).to be_an(String)
    expect(at_search[:data][:id]).to eq("#{hat.id}")
    expect(at_search[:data][:id]).to be_an(String)
    expect(at_search[:data][:id]).to_not eq("#{jacket.id}")
    expect(at_search[:data][:id]).to_not eq("#{treat.id}")

    expect(at_search[:data]).to have_key(:type)
    expect(at_search[:data][:type]).to eq("item")

    expect(at_search[:data][:attributes]).to be_an(Hash)

    attributes = at_search[:data][:attributes]
    expect(attributes[:name]).to be_an(String)
    expect(attributes[:description]).to be_an(String)
    expect(attributes[:unit_price]).to be_an(Float)
    expect(attributes[:merchant_id]).to be_an(Integer)
  end
  
  it 'can find one item greater than a minimum given price' do 
    hat = create(:item, name: "Hat")
    jacket = create(:item, name: "Jacket", unit_price: 45)
    treat = create(:item, name: "Dog treat", unit_price: 55)

    get '/api/v1/items/find?min_price=50'

    expect(response).to be_successful
    min_search = JSON.parse(response.body, symbolize_names: true)
    expect(min_search).to be_an(Hash)
    expect(min_search).to have_key(:data)
    
    data = min_search[:data]
    expect(data).to be_an(Hash)
    expect(data[:id]).to be_an(String)
    expect(data[:type]).to eq("item")
    expect(data[:attributes]).to be_an(Hash)
    expect(data[:attributes][:unit_price]).to be >=(50)
  end

  it 'can find one item less than a maximum given price' do 
    hat = create(:item, name: "Hat")
    jacket = create(:item, name: "Jacket", unit_price: 45)
    treat = create(:item, name: "Dog treat", unit_price: 55)

    get '/api/v1/items/find?max_price=50'

    expect(response).to be_successful
    min_search = JSON.parse(response.body, symbolize_names: true)
    expect(min_search).to be_an(Hash)
    expect(min_search).to have_key(:data)
    
    data = min_search[:data]
    expect(data).to be_an(Hash)
    expect(data[:id]).to be_an(String)
    expect(data[:type]).to eq("item")
    expect(data[:attributes]).to be_an(Hash)
    expect(data[:attributes][:unit_price]).to be <=(50)
  end
end