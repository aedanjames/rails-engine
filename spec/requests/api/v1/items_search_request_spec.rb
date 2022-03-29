require 'rails_helper'

describe 'Items Search API Endpoints' do
  it 'can find all items from a partial case-insensitive search' do 
    create(:item, name: "Hat")
    create(:item, name: "Jacket")
    create(:item, name: "Dog treat")

    get '/api/v1/items/find_all?name=At'

    expect(response).to be_successful

    at_search = JSON.parse(response.body, symbolize_names: true)

    expect(at_search).to be_an(Hash)
    expect(at_search).to have_key(:data)
  end
end